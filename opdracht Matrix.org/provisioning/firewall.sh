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


# Install and set the firewall rules
echo "Configuring the firewall..."
sudo dnf install firewalld policycoreutils-python-utils -y
sudo systemctl start firewalld
sudo systemctl enable firewalld

# Add permissions firewall
echo "Set firewall settings"
sudo firewall-cmd --zone=public --permanent --add-service=ssh
sudo firewall-cmd --zone=public --permanent --add-service=http
sudo firewall-cmd --zone=public --permanent --add-service=https
sudo firewall-cmd --permanent --add-port=8448/tcp
sudo firewall-cmd --permanent --add-port=8008/tcp
sudo firewall-cmd --permanent --add-port=6667/tcp
sudo firewall-cmd --permanent --add-port=9005/tcp
sudo firewall-cmd --permanent --add-port=29334/tcp
sudo firewall-cmd --reload

#setenforce 0
echo "Set semanage settings"
#semanage needs policycoreutils-python-utils
sudo semanage port -a -t http_port_t  -p tcp 8448
sudo semanage port -a -t http_port_t  -p tcp 8008
sudo semanage port -a -t http_port_t  -p tcp 6667
sudo semanage port -a -t http_port_t  -p tcp 9005
sudo semanage port -a -t http_port_t  -p tcp 29334
sudo setsebool httpd_can_network_connect on -P

sudo semanage port -l | grep http_port_t