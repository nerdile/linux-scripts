#!/bin/bash

if [ -z $1 ]; then
  echo Usage: setup.sh adminusername keyname
  exit 1
fi

if [ -z $2 ]; then
  echo Usage: setup.sh adminusername keyname
  exit 2
fi

if [ ! -f ../../secrets/$2.pub ]; then
  echo "Could not find ../../secrets/$2.pub"
  exit 3
fi

user_exists=$(id -u $1 > /dev/null 2>&1; echo $?)
if [ $user_exists -ne 0 ]; then
  echo User $1 does not exist - run adduser to create
  exit 4
fi

if [ ! -d /home/$1/.ssh ]; then
  echo Creating .ssh
  mkdir /home/$1/.ssh
  chown $1 /home/$1/.ssh
  chmod go-rwx /home/$1/.ssh
fi

if [ ! -f /home/$1/.ssh/authorized_keys ]; then
  echo Creating authorized_keys
  touch /home/$1/.ssh/authorized_keys
  chmod go-rwx /home/$1/.ssh/authorized_keys
  chown $1 /home/$1/.ssh/authorized_keys
fi

if grep -q $2 /home/$1/.ssh/authorized_keys; then
  echo Key already added
else
  echo Adding SSH key
  cat ./$2.pub >>/home/$1/.ssh/authorized_keys
fi

apt install sudo git screen iptables-persistent

addgroup sshusers
adduser $1 sshusers
echo PasswordAuthentication no >>/etc/ssh/sshd_config
echo AllowGroups sshusers >>/etc/ssh/sshd_config

adduser $1 sudo
cp ./sudo-nopasswd /etc/sudoers.d/.

cp ./rules /etc/iptables/rules.v4
cp ./rules /etc/iptables/rules.v6
iptables-restore <./rules
ip6tables-restore <./rules

service ssh restart

