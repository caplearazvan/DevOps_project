#!/bin/bash 

sudo apt-get update && sudo apt-get install -y ansible

ansible-playbook /home/ubuntu/setup_jenkins.yaml
