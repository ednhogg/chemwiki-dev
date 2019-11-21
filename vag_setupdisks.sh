#!/bin/bash

if [ ! -e /disksetupcomplete ]; then 
    # Create,prepare and format a second disk
    mkdir -p /var/www/html/{wiki,orig}
    mkdir -p /var/mysql

    echo "SETUP LVM AND FORMAT SECONDARY DISK (IF PVCREATE SUCCEEDS)"
    pvcreate /dev/sdb && \
    vgcreate vgchemwiki /dev/sdb && \
    lvcreate -l +100%FREE -n mysql vgchemwiki && \
    mkfs.xfs -L mysql /dev/vgchemwiki/mysql

    pvcreate /dev/sdc && \
    vgcreate vgchemwikitest /dev/sdc && \ 
    lvcreate -l +100%FREE -n data2 vgchemwikitest && \
    mkfs.xfs -L data2 /dev/vgchemwikitest/data2

    pvcreate /dev/sdd && \  
    vgcreate vgchemwiki3 /dev/sdd && \ 
    lvcreate -l +100%FREE -n orig vgchemwiki3 && \
    mkfs.xfs -L orig /dev/vgchemwiki3/orig

    echo "SETUP FSTAB"
    A=$(grep "^LABEL\=data1" /etc/fstab|wc -l)
    if [ $A -eq 0 ]; then 
        mkdir /var/mysql  
        sed   -i  -e '/^\(LABEL=mysql\).*/{s//\1value/;:a;n;ba;q}' -e '$a"LABEL=mysql /var/mysql xfs defaults 0 0"' /etc/fstab
    fi
    A=$(grep "^LABEL\=data2" /etc/fstab|wc -l)
    if [ $A -eq 0 ]; then   
        sed   -i  -e '/^\(LABEL=data2\).*/{s//\1value/;:a;n;ba;q}' -e '$a"LABEL=data2 /var/www/html/wiki xfs defaults 0 0"' /etc/fstab
    fi

    A=$(grep "^LABEL\=orig" /etc/fstab|wc -l)
    if [ $A -eq 0 ]; then   
        sed   -i  -e '/^\(LABEL=orig\).*/{s//\1value/;:a;n;ba;q}' -e '$a"LABEL=orig /var/www/html/orig xfs ro,defaults 0 0"' /etc/fstab
    fi

    sed -i 's/\"//g' /etc/fstab
    echo "TEST FSTAB"
    tail -n 3 /etc/fstab

    mount -t xfs LABEL=mysql  & \
    mount -t xfs LABEL=data2  & \
    mount -t xfs LABEL=orig & \
    touch /disksetupcomplete
else
    exit
fi