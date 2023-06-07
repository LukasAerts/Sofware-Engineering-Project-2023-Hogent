#! /bin/bash
#
# Provisioning script firewall

#------------------------------------------------------------------------------
# Bash settings
#------------------------------------------------------------------------------

# Enable "Bash strict mode"
#set -o errexit   # abort on nonzero exitstatus
#set -o nounset   # abort on unbound variable
#set -o pipefail  # don't mask errors in piped commands


# Install and set the firewall rules
echo "Configuring the firewall..."
sudo apt install ufw -y
sudo ufw enable

# Add permissions firewall
echo "Set firewall settings"
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw allow 8448/tcp
sudo ufw allow 8008/tcp
sudo ufw allow 6667/tcp
sudo ufw allow 9005/tcp
sudo ufw allow 29334/tcp

# Reload firewall
sudo ufw reload