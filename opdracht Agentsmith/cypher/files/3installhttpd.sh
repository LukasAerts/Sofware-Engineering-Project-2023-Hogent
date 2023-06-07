#!/bin/bash

echo "installing apache"
dnf install -y httpd

echo "changing to port 8080"
sed -i 's/^Listen 80/Listen 127.0.0.1:8080/' /etc/httpd/conf/httpd.conf

# prevent apache from listening on port 443
#sed -i 's/^Listen 443/#Listen 443/g' /etc/httpd/conf.d/ssl.conf

echo "copying some content"
cp /vagrant/files/www/* /var/www/html/
restorecon -Rv /var/www/html/

echo "starting and enabling the service"
systemctl enable --now httpd


#echo "ServerTokens Prod" >> /etc/httpd/conf/httpd.conf
#echo "ServerSignature Off" >> /etc/httpd/conf/httpd.conf

#firewall-cmd --add-service=http --permanent
#firewall-cmd --reload

#systemctl restart httpd
systemctl enable --now httpd
