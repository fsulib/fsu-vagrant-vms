#!/usr/bin/env bash

# Install core utils
yum -y install epel-release
yum -y install vim
yum -y install git
yum -y install tmux

# Install docker utils
yum -y install golang
yum -y install docker-io

# Activate docker service
service docker start

# Set up MySQL container
docker pull mysql
docker run --name mysql-server -p 3306:3306 -e MYSQL_ROOT_PASSWORD=mysql -d mysql

# Add helper scripts
mkdir /home/vagrant/bin
cp /vagrant/scripts/* /home/vagrant/bin
chmod -R 777 /home/vagrant/bin
