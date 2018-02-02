#!/bin/bash
chmod +x wp-cli.phar
./wp-cli.phar core install --url=$1 --title=$2 --admin_user=$3 --admin_password=$4 --admin_email=wordpress@wordpress.com --path=/var/www/html/wordpress --allow-root
