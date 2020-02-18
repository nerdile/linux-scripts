#!/bin/bash
umount /mnt/$1
cryptsetup close $1

