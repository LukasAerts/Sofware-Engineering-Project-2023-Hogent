#! /bin/bash

#------------------------------------------------------------------------------
# Bash settings
#------------------------------------------------------------------------------

# Enable "Bash strict mode"
#set -o errexit   # abort on nonzero exitstatus
#set -o nounset   # abort on unbound variable
#set -o pipefail  # don't mask errors in piped commands

export DEBIAN_FRONTEND=noninteractive

# Update the package lists
sudo apt-get update -y
sudo apt-get upgrade -y

# Install MATE
sudo apt-get install -y mate-desktop-environment-core

# Configure lightdm to use MATE as the default session
sudo apt-get install -y lightdm
sudo bash -c 'echo "user-session=mate" >> /etc/lightdm/lightdm.conf'
sudo systemctl enable lightdm

# Reboot the system to start the GUI
#sudo reboot
