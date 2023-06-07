#! /bin/bash
#
# Provisioning script for trinity web service

#------------------------------------------------------------------------------
# Bash settings
#------------------------------------------------------------------------------

# Enable "Bash strict mode"
set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't mask errors in piped commands

#------------------------------------------------------------------------------

# install apache and the ssl module for our webserver (for https)
dnf install -y httpd mod_ssl php php-mysqlnd php-fpm php-zip php-intl php-opcache php-gd php-mbstring php-gd php-xml php-curl php-json 

# enable webserver (apache)
systemctl enable --now httpd

# configure firewall (for http and https )


firewall-cmd --add-service=http --permanent
firewall-cmd --add-service=https --permanent
firewall-cmd --reload


# we need to adjust the context of folder html for apache and wordpress 
# we also need to alter behavior of apache so it can make connection with a db over network by flipping the boolean on for that feature

restorecon -Rv /var/www/html/ 
setsebool -P httpd_can_network_connect_db on


# changing apache's listening port to 8080 in preparation for the usage of a  reverse proxy
sed -i 's/^Listen 80/Listen 8080/' /etc/httpd/conf/httpd.conf

# prevent apache from listening on port 443
sed -i 's/^Listen 443/#Listen 443/g' /etc/httpd/conf.d/ssl.conf

# prevent apache on giving information and version when scanned with nmap
echo "ServerTokens Prod" >> /etc/httpd/conf/httpd.conf
echo "ServerSignature Off" >> /etc/httpd/conf/httpd.conf

# restart webserver for modifictions to take effect

systemctl restart httpd

