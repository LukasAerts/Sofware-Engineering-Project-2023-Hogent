#! /bin/bash
#
# Provisioning script for CMS on trinity

#------------------------------------------------------------------------------
# Bash settings
#------------------------------------------------------------------------------

# Enable "Bash strict mode"
set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't mask errors in piped commands

#------------------------------------------------------------------------------
# Variables
#------------------------------------------------------------------------------

# Database name
readonly db_name=wordpress_db
# Database user
readonly db_user=wordpress_user
# Database password
readonly db_password='Neo8Trinity'


# Title wordpress
readonly WP_TITLE="The Matrix"
# Username wordpress
readonly WP_ADMIN_USER="admin"
# password wordpress
readonly WP_ADMIN_PASS="matrix123"
# email wordpress
readonly WP_ADMIN_EMAIL="administrator@thematrix.local"

#-----------------------------------------------------------------------------

# Create a config file for wordpress on apache

cat << EOF > /etc/httpd/conf.d/html.conf
<VirtualHost *:8080>
ServerAdmin "${WP_ADMIN_EMAIL}"
DocumentRoot /var/www/html
ServerName thematrix.local
ServerAlias www.thematrix.local

<Directory "/var/www/html">
Options Indexes FollowSymLinks
AllowOverride All
Require all granted
</Directory>

ErrorLog /var/log/httpd/html_error.log
CustomLog /var/log/httpd/html_access.log common
</VirtualHost>
EOF

# Download wordpress

wget https://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz -C /var/www/
mv -T /var/www/wordpress /var/www/html

# make sure permissions and context for folder html are correct
chown -R apache:apache /var/www/html
chcon -t httpd_sys_rw_content_t /var/www/html -R
sudo chmod -R 755 /var/www/html
restorecon -Rv /var/www/html

# configure wordpress

cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

sed -i "s/database_name_here/${db_name}/g" /var/www/html/wp-config.php
sed -i "s/username_here/${db_user}/g" /var/www/html/wp-config.php
sed -i "s/password_here/${db_password}/g" /var/www/html/wp-config.php

# Hide the version information of WordPress
echo "define('WP_DEBUG', false);" | tee -a /var/www/html/wp-config.php > /dev/null

# Set up WordPress installation without user interaction
cat <<EOF > /var/www/html/wp-setup.php
<?php
define( 'WP_INSTALLING', true );
define( 'ABSPATH', '/var/www/html/' );
require_once( ABSPATH . 'wp-config.php' );
require_once( ABSPATH . 'wp-admin/includes/upgrade.php' );
wp_install( '$WP_TITLE', '$WP_ADMIN_USER', '$WP_ADMIN_EMAIL', true, '', '$WP_ADMIN_PASS' );
EOF

# Run the WordPress installation script
php /var/www/html/wp-setup.php

# Remove the installation script
rm /var/www/html/wp-setup.php

# restart web server

systemctl restart httpd
