#!/usr/bin/env bash

# add repositories
sudo add-apt-repository ppa:nginx/stable -y
sudo add-apt-repository ppa:ondrej/php -y

# update
sudo apt-get update
sudo apt-get upgrade -y

# php
sudo apt-get install python-software-properties -y
sudo apt-get update
sudo apt-get install php7.2 -y

# php extensions
sudo apt-get install -y php-memcached php-redis php-pear php-xdebug php-sass php-zmq php7.2-fpm php7.2-gd php7.2-intl php7.2-opcache php7.2-dev
sudo apt-get install -y php7.2-cli php7.2-mysql php7.2-curl php7.2-json php7.2-cgi php7.2-mbstring php7.2-zip php7.2-xml php7.2-bcmath

# php.ini dev
sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.2/fpm/php.ini
sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.2/fpm/php.ini

sudo cat << EOF | sudo tee -a /etc/php/7.2/mods-available/xdebug.ini
xdebug.default_enable=1
xdebug.idekey="PHPSTORM"
xdebug.remote_enable=1
xdebug.remote_port=9000
xdebug.remote_connect_back=1
xdebug.remote_autostart=0
xdebug.remote_host=192.168.98.100
xdebug.remote_autostart=1
EOF

# composer
sudo curl -Ss https://getcomposer.org/installer | php
sudo mv composer.phar /usr/bin/composer

# nginx
sudo apt-get --purge remove apache2 -y
sudo apt-get install nginx -y

sudo rm /etc/nginx/sites-available/default
sudo rm /etc/nginx/sites-enabled/default

sudo cp /vagrant/.vagrant/provision/nginx/server /etc/nginx/sites-available/server
sudo chmod 644 /etc/nginx/sites-available/server
sudo ln -s /etc/nginx/sites-available/server /etc/nginx/sites-enabled/server

# mariadb
sudo apt-get install mariadb-server mariadb-client -y
sudo mysql -u root -proot -e "CREATE USER 'dev'@'localhost' IDENTIFIED BY 'dev'; GRANT ALL PRIVILEGES ON *.* TO 'dev'@'localhost' WITH GRANT OPTION; FLUSH PRIVILEGES;"
sudo mysql -udev -pdev -e "GRANT ALL PRIVILEGES ON *.* TO 'dev'@'%' IDENTIFIED BY 'dev';"
sudo sed -i 's/^bind-address/#bind-address/' /etc/mysql/my.cnf
sudo sed -i 's/^skip-external-locking/#skip-external-locking/' /etc/mysql/my.cnf
sudo service mysql restart

# phpmyadmin
sudo apt-get install unzip -y
sudo wget https://files.phpmyadmin.net/phpMyAdmin/4.8.5/phpMyAdmin-4.8.5-all-languages.zip
sudo unzip phpMyAdmin-4.8.5-all-languages.zip
sudo mv phpMyAdmin-4.8.5-all-languages /usr/share/phpmyadmin
sudo chmod -R 0755 /usr/share/phpmyadmin
sudo rm phpMyAdmin-4.8.5-all-languages.zip

# nodejs
curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
sudo apt-get install -y nodejs

# redis
sudo apt-get install redis-server -y

# set local timezone
sudo rm /etc/localtime && sudo ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime

# install project dependencies
composer update -d /var/www/dev.galactic-conquest.net

# install project database
sudo mysql -udev -pdev -e "CREATE DATABASE gc;"
php /var/www/dev.galactic-conquest.net/vendor/bin/inferno orm:schema-tool:create
php /var/www/dev.galactic-conquest.net/vendor/bin/inferno app:doctrine:fixtures

# install project cron job
sudo crontab -u www-data -l > mycron
echo "*/1 * * * * php /var/www/dev.galactic-conquest.net/vendor/bin/inferno app:tick:run" >> mycron
sudo crontab -u www-data mycron
sudo rm mycron

# start in project dir on vagrant ssh
echo "cd /var/www/dev.galactic-conquest.net" >> /home/vagrant/.bashrc