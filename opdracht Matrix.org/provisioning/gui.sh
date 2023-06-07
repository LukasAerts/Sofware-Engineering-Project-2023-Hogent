#! /bin/bash

#------------------------------------------------------------------------------
# Bash settings
#------------------------------------------------------------------------------

# Enable "Bash strict mode"
set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't mask errors in piped commands

sudo dnf groupinstall 'Server with GUI' -y
sudo dnf install libXtst
sudo systemctl set-default graphical