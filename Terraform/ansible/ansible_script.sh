#!/bin/bash

sudo apt-get update && apt-get install -y ansible 

echo "running playbook"
sudo ansible -u ubuntu /home/ubuntu/playbook.yaml
