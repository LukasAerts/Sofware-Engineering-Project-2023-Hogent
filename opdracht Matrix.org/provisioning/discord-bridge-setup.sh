#! /bin/bash
#
# Provisioning script for Synapse Matrix on theoracle

#------------------------------------------------------------------------------
# Bash settings
#------------------------------------------------------------------------------

# Enable "Bash strict mode"
#set -o errexit   # abort on nonzero exitstatus
#set -o nounset   # abort on unbound variable
#set -o pipefail  # don't mask errors in piped commands

#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# Variables
#------------------------------------------------------------------------------
# Location of provisioning scripts and files
export readonly PROVISIONING_FILES="/provisioning/provisioning"

#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# Code
#------------------------------------------------------------------------------
# Install sqlite db first
echo "Starting SQLITE"
sudo dnf install sqlite -y
echo "Executed SQLITE"

# Install olm library (required by ./build.sh)
cd /usr/local/lib/
echo "Executed lib"
sudo yum install cmake gcc-c++ make -y
echo "Executed gcc"
sudo rm -rf olm #removes all
echo "Executed rm"
git clone https://gitlab.matrix.org/matrix-org/olm.git
echo "Executed clone"
cd olm
echo "Executed cd olm"
sudo mkdir build
echo "Executed mkdir build"
cd build
echo "Executed cd build"
sudo cmake ..
echo "Executed make"
sudo make
sudo make install
echo "Executed make install"

# Incl directory in LD_LIBRARY_PATH env variable and then export to keep permanent after reboots 
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH #/olm
echo 'export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH' >> ~/.bashrc #/olm
source ~/.bashrc
echo "Executed sourcing"


# Installation of bridge
cd /home/vagrant/
sudo rm -rf mautrix-discord #removes all (in case vagrant re-run)
git clone https://github.com/mautrix/discord.git mautrix-discord

echo "Executed clone mautrix"
#sudo chown -R vagrant:vagrant /home/vagrant/mautrix-discord
cd mautrix-discord
sudo dnf install golang -y
./build.sh
echo "Executed build mautrix"

# Create the db for storing data - user and pass 'bridge'
sqlite3 database.db <<EOF
CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY, username TEXT, password TEXT);
INSERT INTO users (username, password) VALUES ('bridge', 'bridge');
.quit
EOF

echo "Executed db"

# Copy config file
cp example-config.yaml config.yaml

echo "Executed cp config"


# Modify the required data in config.yaml using sed
sed -i 's#address: https://matrix.example.com#address: http://theoracle.thematrix.local#g' config.yaml
sed -i 's#address: https://matrix.example.com#address: http://theoracle.thematrix.local#g' config.yaml
sed -i 's#domain: example.com#domain: theoracle.thematrix.local#g' config.yaml
sed -i 's#address: http://localhost:29334#address: http://theoracle.thematrix.local:29334#g' config.yaml
sed -i 's#type: postgres#type: sqlite3-fk-wal#g' config.yaml
sed -i 's#uri: postgres://user:password@host/database?sslmode=disable#uri: file:/home/vagrant/mautrix-discord/database.db?_txlock=immediate#g' config.yaml
sed -i 's#example.com: https://example.com#example.com: http://theoracle.thematrix.local#g' config.yaml
sed -i 's#"example.com": user#"theoracle.thematrix.local": user#g' config.yaml
sed -i 's#"@admin:example.com": admin#"@bot:theoracle.thematrix.local": user#g' config.yaml



# Generate appservice registration
#export LD_LIBRARY_PATH=/usr/local/lib/olm:$LD_LIBRARY_PATH
#echo 'export LD_LIBRARY_PATH=/usr/local/lib/olm:$LD_LIBRARY_PATH' >> ~/.bashrc
#source ~/.bashrc
echo "/usr/local/lib/olm/build" | sudo tee -a /etc/ld.so.conf
echo "/usr/local/lib64" | sudo tee -a /etc/ld.so.conf
sudo ldconfig
./mautrix-discord -g

# Refer registration.yaml from homeserver.yaml
if ! grep -q "app_service_config_files:" /home/vagrant/synapse/homeserver.yaml; then
  echo -e "\napp_service_config_files:\n- /home/vagrant/mautrix-discord/registration.yaml" >> /home/vagrant/synapse/homeserver.yaml
fi

# Run the bridge
#cd /home/vagrant/mautrix-discord/
#sudo ./mautrix-discord

# Creating the service for Mautrix on startup
echo "Creating the Mautrix Discord Bridge service"
sudo cp "${PROVISIONING_FILES}/discord-bridge.service" /etc/systemd/system/
# restart the Synapse service and enable on boot
echo "Starting Mautrix Discord Bridge service..."
sudo systemctl daemon-reload
sudo systemctl enable discord-bridge.service
sudo systemctl start discord-bridge.service
echo "Mautrix Discord Bridge service created, running, starting up on boot"

# Restart synapse
sudo systemctl restart synapse.service