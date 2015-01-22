#!/usr/bin/env bash

# Install core utils
yum -y install epel-release
yum -y install vim
yum -y install git 
yum -y install tmux

# Install Drupal deps
yum -y install httpd
yum -y install php
yum -y install php-devel
yum -y install php-gd
yum -y install php-drush-drush
echo "AddHandler php5-script .php" >> /etc/httpd/conf/httpd.conf
echo "AddType text/html .php" >> /etc/httpd/conf/httpd.conf
cd /var/www
rm -r html
drush dl drupal-7.33
mv drupal-7.33 html
chmod -R 777 /var/www/html
cp /var/www/html/sites/default/default.settings.php /var/www/html/sites/default/settings.php
chmod 777 /var/www/html/sites/default/settings.php
service httpd start

# Install and set up MySQL
yum -y install mysql-server 
yum -y install php-mysql
/sbin/service mysqld start
chkconfig mysqld on
mysql -e "DROP DATABASE test;"
mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host!='localhost';"
mysql -e "CREATE DATABASE drupal;"
mysql -e "CREATE USER 'drupal'@'localhost' IDENTIFIED BY 'drupal';"
mysql -e "GRANT ALL PRIVILEGES ON drupal.* TO drupal@localhost;"
mysql -e "FLUSH PRIVILEGES;"
service httpd restart
