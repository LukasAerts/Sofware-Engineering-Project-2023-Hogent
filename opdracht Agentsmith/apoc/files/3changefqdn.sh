#!/bin/bash

#TODO

# eerder iets met s/^ ... 
sed -i 's/^127.0.1.1 apoc apoc/192.168.20.9 apoc.thematrix.local apoc/g' /etc/hosts

cat /etc/hosts
