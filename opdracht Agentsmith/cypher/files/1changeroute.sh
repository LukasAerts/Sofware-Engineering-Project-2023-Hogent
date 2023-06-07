#!/bin/bash

sudo nmcli connection modify 'System eth1' ipv4.gateway 192.168.20.254 ipv4.route-metric 99

sudo nmcli connection modify 'System eth1' ipv4.dns "192.168.20.1, 8.8.4.4"

sudo nmcli connection modify 'System eth1' ipv4.dns-search "thematrix.local"

sudo systemctl restart NetworkManager