#!/bin/bash

mkdir -p /var/www/html
cd /var/www/html

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

wp core download --allow-root

# Crée le fichier de configuration wp-config.php

wp core config \
	--dbname="$MARIADB_NAME" \
	--dbuser="$MARIADB_USER" \
	--dbpass="$MARIADB_PASSWORD" \
	--dbhost="$MARIADB_HOST" \
	--allow-root


wp core install \
  --url="https://$DOMAIN" \
  --title="$WP_TITLE" \
	--admin_name="$WP_ADMIN_USER" \
	--admin_password="$WP_ADMIN_PASSWORD" \
	--admin_email="$WP_ADMIN_EMAIL" \
	--allow-root

wp user create "$WP_USER" \
	"$WP_EMAIL" \
	--role=author \
	--user_pass="$WP_PASSWORD" \
	--allow-root

wp plugin install redis-cache --activate --allow-root

mkdir -p /run/php/
/usr/sbin/php-fpm7.4 -F
