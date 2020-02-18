# Setting up iscsi targets

## Overview
- Target vs. Initiator: Target=server, Initiator=client (Target has the physical
  storage, Initiator connects to drives over the network)
- Backstores: "Backing storage" - aka where the data actually lives.  Usually an LVM
  Logical Volume.  Can also be a file.
   - Block: a block device (partition or LV)
   - fileio: a backing file on a mounted drive

### iScsi Hierarchy
- iscsi
  - target iqn
    - tpg1 - a Portal Group of related storage
      - acls
        - initiator iqn - attributes: auth user, pass
          - mapped luns - access level
      - luns
        - lun0... - each is mapped to a backstore
      - portals
        - ip address / port

## Setting up iscsi

**Prereqs**
```
apt install targetcli-fb
```

Also, Create the target.service that is missing on Debian

**Recovering an existing setup**
Recover from backup: /etc/rtslib-fb-target/saveconfig.json

**Creating a target portal group**
Example: Creating a tpg for filebox on 192.168.19.10:3260

In targetcli:
```
/iscsi create iqn.2019-12.mysan.vm1:filebox
cd /iscsi/iqn.2019-12.mysan.vm1:filebox/tpg1
portals/ delete 0.0.0.0 3260
portals/ create 192.168.19.10 3260
```

**Attaching an LV to a TPG**
Example: Attach lvmydata from vgfilebox to the filebox tpg

In targetcli:
```
/backstores/block create lvmyvol /dev/mapper/vgfilebox-lvmyvol
/iscsi/iqn.2019-12.mysan.vm1:filebox/tpg1/luns create /backstores/block/lvmyvol
```

**Granting a server (initiator) access to a TPG**
Example: Grant vm2 access to the filebox tpg

In targetcli:
```
cd /iscsi/iqn.2019-12.mysan.vm1:filebox/tpg1/acls
create iqn.2019-12.mysan.vm2:vm2
cd iqn.2019-12.mysan.vm2:vm2
set auth userid=myuser
set auth password=mypass
```

## Setting up iScsi initiators
```
apt install open-iscsi
```

/etc/iscsi/iscsid.conf
```
node.session.auth.authmethod = CHAP
node.session.auth.username = myuser
node.session.auth.password = mypass
node.startup = automatic
```

In bash:
```
iscsiadm -m discovery -t st -p 192.168.19.10
iscsiadm -m node --targetname "iqn.2019-12.mysan.vm1:filebox" --portal "192.168.19.10:3260" --login
```

## Other notes
You probably want to figure out what iqn the initiator uses before you create an acl for it