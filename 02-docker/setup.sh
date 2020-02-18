#!/bin/bash
apt update
apt install apt-transport-https ca-certificates curl gnupg2 software-properties-common

curl -sSL https://get.docker.com | sh

# curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
# add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"

# apt update
# apt install docker-ce

if [ ! -z $1 ]; then
  adduser $1 docker
fi

