#!/usr/bin/env bash

yum -y install epel-release 
yum -y install vim 
yum -y install git 
yum -y install tmux 
yum -y install httpd 
yum -y install php 
yum -y install php-devel 
yum -y install php-gd 
yum -y install mysql-server 
yum -y install php-mysql 

echo "Configuring new system..."
echo "AddHandler php5-script .php" >> /etc/httpd/conf/httpd.conf
echo "AddType text/html .php" >> /etc/httpd/conf/httpd.conf
cd /var/www
rm -r html
cp -r /vagrant/dependencies/ojs /var/www/html
chmod -R 777 /var/www/html
mkdir /var/www/files
chmod 777 /var/www/files
cat /etc/httpd/conf/httpd.conf | sed -e 's/AllowOverride\ None/AllowOverride\ All/' > /tmp/httpd.conf
rm /etc/httpd/conf/httpd.conf
cp /tmp/httpd.conf /etc/httpd/conf/httpd.conf
service httpd start
/sbin/service mysqld start
chkconfig mysqld on

mysql -e "CREATE DATABASE ojs;"
mysql -e "CREATE USER 'ojs'@'localhost' IDENTIFIED BY 'ojs';"
mysql -e "GRANT ALL PRIVILEGES ON ojs.* TO ojs@localhost;"
mysql -e "FLUSH PRIVILEGES;"
service httpd restart
