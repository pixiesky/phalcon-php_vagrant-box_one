#!/usr/bin/env bash
# REMEMBER!! to install the vbguest plugin: vagrant plugin install vagrant-vbguest
# https://github.com/dotless-de/vagrant-vbguest

echo Running update
yum update -y

echo Installing LAMP stack stuff ....
cd ~
wget http://www.percona.com/redir/downloads/percona-release/percona-release-0.0-1.x86_64.rpm
sudo rpm -Uvh percona-release-0.0-1.x86_64.rpm
sudo yum -y install Percona-Server-client-55 Percona-Server-server-55

# PHP 5.4 for CentOS 6.x
sudo rpm -Uvh http://mirror.webtatic.com/yum/el6/latest.rpm

sudo yum install -y httpd httpd-devel
#Install php and other things!
sudo yum install -y pcre-devel php54w php54w-mysql php54w-mcrypt php54w-devel gcc make libtool


# For PHP 5.5 visit https://webtatic.com/packages/php55/ for more info.

echo changing httpd file structure
sudo rm -rf /var/www/html
sudo ln -fs /vagrant /var/www/html
echo Complete


echo Changing web server configuration
sudo -i

echo Setting localtime to GB ...
mv /etc/localtime /etc/localtime.old
ln -s /usr/share/zoneinfo/GB /etc/localtime

echo Installing Phalcon
yum -y install pcre-devel git
mkdir /phalcon
cd /phalcon
git clone git://github.com/phalcon/cphalcon.git ./
cd build
./install

cd /etc/php.d
touch zz_phalcon.ini
echo extension=/usr/lib64/php/modules/phalcon.so >> zz_phalcon.ini

echo Starting services ....

/etc/init.d/httpd start
/sbin/service mysql start

echo Adding tp startup ....
chkconfig mysql on
chkconfig httpd on

echo Creating admin account
mysql -u root < /vagrant/mysql-setup.sql
# mysql -u root < /vagrant/my-site.sql

rm /etc/udev/rules.d/70-persistent-net.rules