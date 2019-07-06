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
sudo apt-get install php7.3 -y

# php extensions
sudo apt-get install -y php-memcached php-redis php-pear php-xdebug php-sass php-zmq php7.3-fpm php7.3-gd php7.3-intl php7.3-opcache php7.3-dev
sudo apt-get install -y php7.3-cli php7.3-mysql php7.3-curl php7.3-json php7.3-cgi php7.3-mbstring php7.3-zip php7.3-xml php7.3-bcmath

# php.ini dev
sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.3/fpm/php.ini
sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.3/fpm/php.ini

sudo cat << EOF | sudo tee -a /etc/php/7.3/mods-available/xdebug.ini
xdebug.default_enable=1
xdebug.idekey="PHPSTORM"
xdebug.remote_enable=1
xdebug.remote_port=9000
xdebug.remote_connect_back=1
xdebug.remote_host=192.168.98.100
xdebug.remote_autostart=0
xdebug.profiler_enable = 0;
xdebug.profiler_enable_trigger = 1;
xdebug.profiler_output_dir = "/var/www/dev.galactic-conquest.net/data/profile"
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

// create db
sudo mysql -udev -pdev -e "CREATE DATABASE gc;"

# start in project dir on vagrant ssh
echo "cd /var/www/dev.galactic-conquest.net" >> /home/vagrant/.bashrc

# debug console commands
echo "export XDEBUG_CONFIG='idekey=PHPSTORM remote_host=10.0.2.2'" >> /home/vagrant/.bashrc

# install project dependencies and install project
composer install -d /var/www/dev.galactic-conquest.net
composer setup -d /var/www/dev.galactic-conquest.net

# install project cron job
sudo crontab -u www-data -l > mycron
echo "*/1 * * * * php /var/www/dev.galactic-conquest.net/vendor/bin/inferno app:tick:run" >> mycron
sudo crontab -u www-data mycron
sudo rm mycron