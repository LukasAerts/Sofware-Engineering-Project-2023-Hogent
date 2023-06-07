#! /bin/bash

# Enable "Bash strict mode"
set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't mask errors in piped commands

# Install required packages
sudo dnf install git -y


# Clone QuakeJS repository
git clone https://github.com/inolen/quakejs.git

# Go to cloned folder
cd quakejs

# install ws
sudo npm install ws

# Give correct path and rights
sudo chown -R vagrant:vagrant /home/vagrant/quakejs

# go to ioq3 folder
cd ioq3

# Use https://
git config --global url."https://".insteadOf git://

# Initialize and update submodules
git submodule update --init

# go back to quakejs
cd ..

# Install dependencies
sudo npm install -g npm@9.6.5

# Create server.cfg file
mkdir -p base/baseq3
cat << EOF > base/baseq3/server.cfg
seta sv_hostname "BaldnB Carnagefield"
seta sv_maxclients 12
seta g_motd "System Engineering Project: completed successfully"
seta g_quadfactor 3
seta g_gametype 0
seta timelimit 15
seta fraglimit 25
seta g_weaponrespawn 3
seta sv_public 1
seta g_inactivity 3000
seta g_forcerespawn 0
seta rconpassword "22admin23"
set d1 "map q3dm7 ; set nextmap vstr d2"
set d2 "map q3dm17 ; set nextmap vstr d1"
seta sv_ip 192.168.20.5:27960
vstr d1
EOF

# Quake3 script finished successfully

echo "Quake 3 Server is ready for manual install and server exec."
echo "Please log in the VM"
echo "user: vagrant, password: vagrant."

# Start the server manually with following command:
# sudo node build/ioq3ded.js +set fs_game baseq3 +set dedicated 2 +set net_ip 192.168.20.5 +set net_port 27960 +exec server.cfg

