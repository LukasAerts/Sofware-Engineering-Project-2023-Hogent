#!/bin/bash

#TODO

echo "22Admin23" | realm join --user=Administrator --computer-ou="OU=Servers,OU=DomainWorkstations,DC=thematrix,DC=local" thematrix.local

echo "you can log in to the domain now"
echo "first time:"
echo 'su - "THEMATRIX\kea_ree"'
echo "later"
echo 'su - kea_ree@thematrix.local'
echo 'password: 22Student23'


