#! /bin/bash
#
# Provisioning script for Synapse Matrix on theoracle

#------------------------------------------------------------------------------
# Bash settings
#------------------------------------------------------------------------------

# Enable "Bash strict mode"
set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't mask errors in piped commands

#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# Variables
#------------------------------------------------------------------------------
export VAGRANT="/home/vagrant/synapse"
# Location of provisioning scripts and files
export readonly PROVISIONING_FILES="/provisioning/provisioning"

#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# Code
#------------------------------------------------------------------------------

# Stap 1: Install dependencies
echo "Installing dependencies"
sudo dnf install dos2unix python3 python3-pip libffi-devel python3-devel redhat-rpm-config gcc libtiff-devel libjpeg-devel freetype-devel libwebp-devel libxslt-devel libpq-devel libffi-devel openssl-devel python3-devel libicu-devel jq wget -y
sudo dnf groupinstall "Development Tools" -y

#Stap 2: Create virtual environment for Matrix Synapse
echo "Setting up Python Virtual Environment"
mkdir -p $VAGRANT
chown -R $USER:$USER $VAGRANT
		#export PATH="/usr/local/bin:$PATH"
		#source ~/.bash_profile
echo $PATH
cd $VAGRANT
python3 -m venv $VAGRANT/env
source $VAGRANT/env/bin/activate
#su
pip3 install --upgrade pip virtualenv six packaging appdirs
pip3 install --upgrade setuptools
pip3 install -U matrix-synapse
#su vagrant
cd $VAGRANT
#sudo chown -R $USER:$USER $VAGRANT

# Generate homeserver.yaml file
python3 -m synapse.app.homeserver --server-name theoracle.thematrix.local --config-path homeserver.yaml --generate-config --report-stats=no

    #sed -i 's/x_forwarded: true/x_forwarded: false/g' homeserver.yaml

#Start the Matrix Synapse server
		#export PATH="/usr/local/bin:$PATH"
		#source ~/.bash_profile
#synctl upgrade
synctl start
deactivate #exit the virtual environment


# Creating the service for Synapse on startup - within the virtual environment
echo "Creating the Synapse service"
sudo cp "${PROVISIONING_FILES}/synapse.service" /etc/systemd/system/
# restart the Synapse service and enable on boot
echo "Starting Synapse..."
sudo systemctl daemon-reload
sudo systemctl enable synapse.service
sudo systemctl start synapse.service
    #sudo systemctl status synapse.service
echo "Synapse service created, running, starting up on boot"

# Stap 3: Install and configure nginx
echo "Installing the Nginx server"
sudo dnf install nginx -y

# configureren van Nginx (reverse proxy)
echo "Configuring the Nginx server"
sudo cp "${PROVISIONING_FILES}/matrix.conf" /etc/nginx/conf.d/
cd $VAGRANT
echo "Nginx configured"

# take care of SSL certs
sudo mkdir -p /etc/ssl/private
sudo chmod 700 /etc/ssl/private
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt \
  -subj "/C=BE/ST=OV/L=Ghent/O=Hogent/CN=theoracle.thematrix.local"
sudo chmod 600 /etc/ssl/private/nginx-selfsigned.key /etc/ssl/certs/nginx-selfsigned.crt

#add thematrix.local and theoracle.thematrix.local to hosts file to resolve the domains names
echo "127.0.0.1 theoracle.thematrix.local" | tee -a /etc/hosts
echo "192.168.20.4 theoracle.thematrix.local" | tee -a /etc/hosts

# restart nginx service
echo "Restarting Nginx..."
sudo systemctl restart nginx
sudo systemctl enable nginx

# Stap 5: Create the users:
# restart synapse first...
echo "Restarting Synapse..."
#sudo chown -R $USER:$USER $VAGRANT
python3 -m venv $VAGRANT/env
cd $VAGRANT
source env/bin/activate
      #synctl stop
      #echo "Synapse stopped"

      # enable registration
      #sudo -- bash -c 'echo "enable_registration_without_verification: true" >> /home/vagrant/synapse/homeserver.yaml'
synctl restart
sleep 10 # wait for the restart to finish

# create the users if not done so yet
if [ -e "/home/vagrant/synapse/user-room-config.sh" ]; then
  echo "user-room-config.sh already exists. Skipping user creation."
else
  echo 'Creating the users and rooms in Matrix...' | boxes -d shell -p a1l2
  cp "${PROVISIONING_FILES}/user-room-config.sh" $VAGRANT/
  sudo dos2unix $VAGRANT/user-room-config.sh
  source $VAGRANT/user-room-config.sh #to make vars usable in other script
  echo 'Done creating the users and rooms in Matrix!' | boxes -d shell -p a1l2
fi

# Stap 6: Message on nginx webserver down script:
echo "Copying override.conf file"
sudo cp "${PROVISIONING_FILES}/override.conf" /etc/systemd/system/nginx.service.d/
echo "Creating the server notification message script..."
sudo systemctl restart nginx
cp "${PROVISIONING_FILES}/send_synapse_message.sh" /home/vagrant/synapse/send_synapse_message.sh
sudo dos2unix /home/vagrant/synapse/send_synapse_message.sh
chmod +x /home/vagrant/synapse/send_synapse_message.sh
echo "File copied... going on..."
sudo systemctl daemon-reload

# Stap 7: Install Element client
sudo dnf install flatpak -y
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install flathub im.riot.Riot -y
  #flatpak run im.riot.Riot - only to be used in cmd shell
