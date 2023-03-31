#!/bin/bash
sudo apt-get update
sudo apt-get install -y mysql-server
sudo apt-get install -y apache2 php php-mysql
sudo apt install apache2 \
                 ghostscript \
                 libapache2-mod-php \
                 mysql-server \
                 php \
                 php-bcmath \
                 php-curl \
                 php-imagick \
                 php-intl \
                 php-json \
                 php-mbstring \
                 php-mysql \
                 php-xml \
                 php-zip
sudo mkdir -p /svr/www
sudo chown www-data: /srv/www
curl https://wordpress.org/latest.tar.gz | sudo -u www-data tar zx -C /srv/www
sudo touch /etc/apache2/sites-available/wordpress.conf
sudo bash -c "cat > /etc/apache2/site-available/wordpress.conf" <<EOF
<VirtualHost *:80>
    DocumentRoot /var/www/wordpress
    <Directory /var/www/wordpress>
        Options FollowSymLinks
        AllowOverride Limit Options FileInfo
        DirectoryIndex index.php
        Require all granted
    </Directory>
    <Directory /srv/www/wordpress/wp-content>
        Options FollowSymLinks
        Required all granted
    </Directory>
</VirtualHost>
EOF
sudo a2ensite wordpress
sudo a2enmod rewrite
sudo a2dissite 000-default
sudo systemctl restart apache2
sudo mysql -u root -e "SELECT user,authentication_string,plugin,host FROM mysql.user;"
sudo mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Abcd1234567890-';"
sudo mysql -u root -p"Abcd1234567890-" -e "FLUSH PRIVILLAGES;"
sudo mysql -u root -p"Abcd1234567890-" -e "SELECT user,authentication_string,plugin,host FROM mysql.user;"
sudo mysql -u root -p"Abcd1234567890-" -e "CREATE USER 'devopscilsy'@'localhost' IDENTIFIED BY '1234567890';"
sudo mysql -u root -p"Abcd1234567890-" -e "GRANT ALL PRIVILLAGES ON *.* to 'devopscilsy'@'localhost';"
sudo mysql -u "devopscilsy" -p"1234567890-" -e "CREATE DATABASE wordpress;"
sudo mysql -u "devopscilsy" -p"1234567890-" -s "show databases;"
sudo -u www-data cp /home/rumi/vagrant/wp-config.php /srv/www/wordpress/wp-config.php
