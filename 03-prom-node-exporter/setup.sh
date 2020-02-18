#!/bin/bash

SYSARCH=$(uname -m)

case "$SYSARCH" in
  armv7l) SYSARCH="armv7";;
  x86_64) SYSARCH="amd64";;
esac

# https://prometheus.io/download/
# download latest release of node_exporter
curl -s https://api.github.com/repos/prometheus/node_exporter/releases/latest \
| grep "browser_download_url" \
| grep "linux-$SYSARCH" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi -

tar -xvf node_exporter*.tar.gz
pushd node_exporter*/
cp node_exporter /usr/local/bin
popd

groupadd --system prometheus
useradd -s /sbin/nologin --system -g prometheus prometheus

cp node_exporter.service /etc/systemd/system/.

systemctl daemon-reload
systemctl start node_exporter
systemctl enable node_exporter

echo "Remember to update iptables rules to allow access from your prometheus host"
