#!/bin/bash
set -ex

## Install Docker ##
sudo apt-get update
sudo apt-get install -y cloud-utils apt-transport-https ca-certificates curl software-properties-common
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install -y docker-ce
sudo systemctl start docker
sudo usermod -aG docker ubuntu
sudo chmod 666 /var/run/docker.sock
sudo apt-get install -y wget
