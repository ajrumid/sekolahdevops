#!/bin/bash
echo "Menyiapkan Installasi Web server"
apt-get update
echo "Melakukan Installasi Webserver"
apt-get install -y apache2 zip unzip
echo "Download file apps landing page"
wget https://github.com/sdcilsy/landing-page/archive/refs/heads/master.zip
echo "Memindahkan data"
sudo rm /var/www/html/* 
sudo rm -R /var/www/html
sudo mv landing-page-master/* /var/www/html
echo "restart service apache2"
systemctl restart apache2
