#!/bin/bash
cryptsetup -y -v luksFormat $1
cryptsetup luksOpen $1 $2
mkfs.ext4 /dev/mapper/$2
mkdir /mnt/$2
mount /dev/mapper/$2 /mnt/$2

