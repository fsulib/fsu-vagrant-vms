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
drush dl drupal-7.28
mv drupal-7.28 html
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

# Install modules with specifc version numbers to reflect Julio site
drush dl block_titlelink-7.x-1.3

<<COM
calendar: 7.x-3.4
captcha: 7.x-1.0
cas: 7.x-1.3
css_injector: 7.x-1.8
custom_search: 7.x-1.12
devel: 7.x-1.3
ds: 7.x-2.4
email_sender_override: 7.x (this module is tiny and probably not neccessary)
fancy_login: 7.x-3.0-beta6
field_permissions: 7.x-1.0-beta2
google_analytics: 7.x-1.3
htmlpurifier: 7.x-1.0
jquery_plugin: 7.x-1.0
js_injector: 7.x-2.0
masquerade: 7.x-1.0-rc7
menu_attributes: 7.x-1.0-rc2
menu_block: 7.x-2.3
menu_token: 7.x-1.0-beta5
nice_menus: 7.x-2.4
pathologic: 7.x-2.11
rules: 7.x-2.6
views_slideshow: 7.x-3.1
webform: 7.x-3.20
webform_report: 7.x-1.0
webform_rules: 7.x-1.6

LIBS:
CAS (phpCAS): 1.3.2
FirePHPCore: 0.3.1
htmlpurifier: 4.5.0
jquery.cycle: 3.0.3
COM
