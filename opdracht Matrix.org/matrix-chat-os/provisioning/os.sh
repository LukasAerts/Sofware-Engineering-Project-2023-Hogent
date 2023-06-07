#! /bin/bash
#
# Provisioning script for chat VM on theoracle

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

#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# Code
#------------------------------------------------------------------------------
# Update the package lists
sudo apt-get update -y
sudo apt-get upgrade -y

# First add hostname of server VM to this VM
echo "192.168.20.4 theoracle.thematrix.local" | sudo tee -a /etc/hosts

# Install required dependencies
sudo apt-get install -y flatpak gnome-software-plugin-flatpak

# Add Flathub repository
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Install Flatpak
sudo apt-get install -y flatpak

# Install Element (Riot)
sudo flatpak install -y flathub im.riot.Riot

# Install Fractal
sudo flatpak install -y flathub org.gnome.Fractal

# Start Element
#flatpak run im.riot.Riot
