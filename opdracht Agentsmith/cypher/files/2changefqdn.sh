#!/bin/bash

#TODO

# eerder iets met s/^ ... 
sed -i 's/^127.0.1.1 cypher cypher/192.168.20.7 cypher.thematrix.local cypher/g' /etc/hosts

cat /etc/hosts
