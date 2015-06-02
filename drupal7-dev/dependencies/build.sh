#!/usr/bin/env bash

yum -y install epel-release 
yum -y install vim 
yum -y install git 
yum -y install tmux 
yum -y install httpd 
yum -y install php 
yum -y install php-devel 
yum -y install php-gd 
yum -y install php-drush-drush 
yum -y install mysql-server 
yum -y install php-mysql 

echo "Configuring new system..."
echo "AddHandler php5-script .php" >> /etc/httpd/conf/httpd.conf
echo "AddType text/html .php" >> /etc/httpd/conf/httpd.conf
cd /var/www
rm -r html
cp -r /vagrant/dependencies/FSULibraries_backrest/docroot /var/www
mv docroot html
chmod -R 777 /var/www/html
rm /var/www/html/sites/default/settings.php
cp /vagrant/dependencies/settings.php /var/www/html/sites/default/settings.php
cp /vagrant/dependencies/.htaccess /var/www/html/.htaccess
cat /etc/httpd/conf/httpd.conf | sed -e 's/AllowOverride\ None/AllowOverride\ All/' > /tmp/httpd.conf
rm /etc/httpd/conf/httpd.conf
cp /tmp/httpd.conf /etc/httpd/conf/httpd.conf
service httpd start

/sbin/service mysqld start
chkconfig mysqld on

mysql -e "CREATE DATABASE devdb;"
mysql -e "CREATE USER 'dev'@'localhost' IDENTIFIED BY 'dev';"
mysql -e "GRANT ALL PRIVILEGES ON devdb.* TO dev@localhost;"
mysql -e "FLUSH PRIVILEGES;"
mysql -u dev --password=dev devdb < /vagrant/dependencies/FSULibraries_backrest/database.sql
service httpd restart

adduser backrest
