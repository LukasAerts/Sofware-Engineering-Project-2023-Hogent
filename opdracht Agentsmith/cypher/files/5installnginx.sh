#! /bin/bash

dnf install nginx -y

cp /vagrant/files/nginx.conf /etc/nginx/nginx.conf
chmod 644 /etc/nginx/nginx.conf
restorecon -Rv /etc/nginx/

systemctl enable --now nginx

# firewall rules

firewall-cmd --add-service=http --permanent
firewall-cmd --add-service=https --permanent
firewall-cmd --reload

#disble secure linux to be safe?
setenforce Permissive
