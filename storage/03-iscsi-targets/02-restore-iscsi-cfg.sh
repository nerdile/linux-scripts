#!/bin/bash

# This command restores the iscsi config from backup
# Prior to doing this:
# - The MDADM raid arrays must be attached and healthy
# - The PV's, VG's, and LV's must be imported and mapped

targetcli restore saveconfig.json
