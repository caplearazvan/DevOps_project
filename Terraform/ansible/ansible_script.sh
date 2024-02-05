#!/bin/bash

sudo apt-get update && sudo apt-get install -y ansible 

echo "running playbook"
sudo ansible-playbook -u ubuntu /home/ubuntu/playbook.yaml
