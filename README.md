# Linux-Setup

Scripts for setting up Linux VM's

## Basic host setup

### 01-hostsetup
Baseline setup for how I like my Linux VM's.

Usage: sudo ./setup.sh adminusername adminkey

Where adminusername is the name of the regular user
account you plan to use for remote access and sysadmin.
And adminkey is in ../secrets/adminkey.pub with adminkey in the comment.

### 02-docker
Install Docker on the machine

Usage: sudo ./setup.sh adminusername

### 03-prom-node-exporter
Install Node-Exporter for prometheus

Usage: sudo ./setup.sh
