#!/usr/bin/env bash
current_user=$(whoami)

sudo apt remove -y docker docker-engine docker.io
sudo apt update && sudo apt -y upgrade
sudo apt -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
sudo apt update
sudo apt -y install docker-ce
sudo usermod -aG docker ${current_user}