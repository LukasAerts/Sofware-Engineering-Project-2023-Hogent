#! /bin/bash


openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /root/cert.key -out /root/cert.crt -subj "/C=BE/ST=OV/L=Ghent/O=Hogent/CN=thematrix.local"

sudo mkdir /etc/nginx/certs

sudo mv /root/cert.crt /etc/nginx/certs/

sudo mv /root/cert.key /etc/nginx/certs/



systemctl restart nginx