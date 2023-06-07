#! /bin/bash

# Enable "Bash strict mode"
set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't mask errors in piped commands

# Disable connecting via ssh as root

sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config

# disable password based authentication 

sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

# enable ssh key authentication

sed -i 's/^#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config

# restart sshd service

systemctl restart sshd

#SELinux inschakelen

sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

# Accept ping

sudo iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT

#Nano-install

sudo dnf install nano -y

#Git-install

sudo yum install -y git

#bind-utils install

sudo dnf install bind-utils -y

#lsof install in order to run sudo lsof -i :27960

sudo dnf install lsof -y

#install systemd-resolved package
sudo dnf install systemd-resolved -y

# dozer installed

echo "dozer script has been executed successfully"

