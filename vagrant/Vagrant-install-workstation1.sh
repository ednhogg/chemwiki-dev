#!/bin/bash
# Setup packages
yum -y upgrade
yum -y install vim rsync screen mariadb-server httpd php mysql-php 

systemctl enable httpd mariadb
systemctl start httpd mariadb
