#! /bin/bash
#
# Provisioning script for reverse proxy on trinity

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

# Export variables for Nginx
export host="\$host";
export request_uri="\$request_uri"
export http_host="\$host"
export remote_addr="\$remote_addr"
export proxy_add_x_forwarded_for="\$proxy_add_x_forwarded_for"
export scheme="\$scheme"

#------------------------------------------------------------------------------

#install nginx to use a reverse proxy
dnf install nginx -y

# Create the directory to were we will save our self-signed certificate and key
mkdir -p /etc/ssl/private

# Set the correct permissions on that directory
chmod 700 /etc/ssl/private

# Generate the self-signed certificate and key
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt \
  -subj "/C=BE/ST=OV/L=Ghent/O=Hogent/CN=thematrix.local"

# Set the correct permissions on the self-signed certificate and key
chmod 600 /etc/ssl/private/nginx-selfsigned.key /etc/ssl/certs/nginx-selfsigned.crt


# start and enable nginx (web service that will act as reverse proxy )
systemctl enable --now nginx

# prevent nginx to give information or version when scanned via nmap
sed -i '/http {/a \    server_tokens off;' /etc/nginx/nginx.conf

#configure Nginx to listen on port 80 and 443 for requests to www.thematrix.local and thematrix.local, and forward them to Apache on port 8080
cat <<EOF > /etc/nginx/conf.d/html.conf
server {
    listen 80;
    listen [::]:80;
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    server_name thematrix.local www.thematrix.local;
	
	if ($scheme != "https") {
        return 301 https://$host$request_uri;
    }

    ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;
    ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;


    location / {
        proxy_pass http://127.0.0.1:8080;
		proxy_redirect off;
		proxy_set_header X-Real-IP $remote_addr;
		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
		proxy_set_header Host $http_host;
    }
}
EOF


#configure Nginx to listen on port 80 and 443 for requests to www.rallly.thematrix.local and rallly.thematrix.local, and forward them to Apache on port 3000
cat <<EOF > /etc/nginx/conf.d/rallly.conf
server {
    listen 80;
    listen [::]:80;
	listen 443 ssl http2;
    listen [::]:443 ssl http2;
    server_name rallly.thematrix.local www.rallly.thematrix.local;
	
	if ($scheme != "https") {
        return 301 https://$host$request_uri;
    }

	ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;
    ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;
		
	
    location / {
        proxy_pass http://127.0.0.1:3000;
		proxy_redirect off;
		proxy_set_header X-Real-IP $remote_addr;
		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
		proxy_set_header Host $http_host;	
    }
}
EOF

# restart nginx and httpd
systemctl restart httpd
systemctl restart nginx