#!/bin/bash

apt install targetcli-fb

if [ ! -f /etc/init.d/rtslib-fb-targetctl ]; then
  cp rtslib-fb-targetctl /etc/init.d/rtslib-fb-targetctl
fi

chmod 755 /etc/init.d/rtslib-fb-targetctl
systemctl enable rtslib-fb-targetctl
