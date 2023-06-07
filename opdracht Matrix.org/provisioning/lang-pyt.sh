#! /bin/bash
#
# Provisioning script for language

#------------------------------------------------------------------------------
# Bash settings
#------------------------------------------------------------------------------

# Enable "Bash strict mode"
set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't mask errors in piped commands

localectl set-keymap us
sudo dnf update -y
dnf install glibc-langpack-en.x86_64 -y
localectl set-locale LANG=en_US.UTF-8