#!/bin/bash
echo "SETTING UP PACKAGES"

yum -y upgrade

umount /var/www/html/orig /var/www/html/wiki

mount -o ro,remount /var/www/html/orig 
mount  /var/www/html/wiki
