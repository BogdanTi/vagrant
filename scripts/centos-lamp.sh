#!/bin/bash

#LAMP stack Vagrant provision for CentOS7
#update CentOS with any patches
yum update -y --exclude=kernel

#install tools
yum install -y nano git unzip screen mc wget

#install apache and make it run
yum install -y httpd httpd-devel httpd-tools
systemctl enable httpd
systemctl stop httpd

rm -rf /var/www/html
ln -s /vagrant /var/www/html
chcon --user system_u --type httpd_sys_content_t -Rv /vagrant/

systemctl start httpd

# install php

yum install -y php php-cli php-common php-devel php-mysql

# install mysql and make it run

wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
rpm -ivh mysql-community-release-el7-5.noarch.rpm
yum install -y mysql-server mysql-devel
systemctl enable mysqld
systemctl start mysqld

mysql -u root -e "SHOW DATABASES";

#Download Starter content

systemctl restart httpd