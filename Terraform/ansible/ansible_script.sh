#!/bin/bash 
sleep 300

sudo apt-get upgrade -y && sudo apt update && sudo apt install -y ansible

ansible-playbook /home/ubuntu/playbook.yaml