#! /bin/bash
#
# Provisioning script for trinity basic config

#------------------------------------------------------------------------------
# Bash settings
#------------------------------------------------------------------------------

# Enable "Bash strict mode"
set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't mask errors in piped commands

#------------------------------------------------------------------------------

# add fqdn of server trinity to the hosts file
sed -i 's/^127.0.1.1 trinity trinity/127.0.1.1 trinity.thematrix.local trinity/' /etc/hosts

#add thematrix.local and rallly.thematrix.local To hosts file to resolve the domains names
echo "127.0.0.1 thematrix.local" | tee -a /etc/hosts
echo "192.168.20.2 thematrix.local" | tee -a /etc/hosts
echo "127.0.0.1 rallly.thematrix.local" | tee -a /etc/hosts
echo "192.168.20.2 rallly.thematrix.local" | tee -a /etc/hosts


# Disable connecting via ssh as root

sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config

# disable password based authentication 

sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

# enable ssh key authentication

sed -i 's/^#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config

# Hide the version information of OpenSSH
sed -i 's/^#VersionAddendum none/VersionAddendum none/' /etc/ssh/sshd_config

# make sure that owner and primary group of folder .ssh is user and group vagrant

chown -R vagrant:vagrant /home/vagrant/.ssh

# set correct permission on the ssh directory

chmod 700 /home/vagrant/.ssh

# set correct permission authorized keys file in the ssh directory 

chmod 600 /home/vagrant/.ssh/authorized_keys


# restart sshd service

systemctl restart sshd