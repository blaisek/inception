#!/bin/bash

source ./srcs/.env
mkdir -p /var/www/html
cd /var/www/html

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

wp core download --allow-root

# Affichage des valeurs des variables
echo "MARIADB_NAME=$MARIADB_NAME"
echo "MARIADB_USER=$MARIADB_USER"
echo "MARIADB_PASSWORD=$MARIADB_PASSWORD"
echo "MARIADB_HOST=$MARIADB_HOST"
echo "DOMAIN=$DOMAIN"
echo "WP_ADMIN_USER=$WP_ADMIN_USER"
echo "WP_ADMIN_PASSWORD=$WP_ADMIN_PASSWORD"
echo "WP_ADMIN_EMAIL=$WP_ADMIN_EMAIL"
echo "WP_USER=$WP_USER"
echo "WP_PASSWORD=$WP_PASSWORD"
echo "WP_EMAIL=$WP_EMAIL"

# Crée le fichier de configuration wp-config.php
wp core config \
	--dbname=$MARIADB_NAME \
	--dbuser=$MARIADB_USER \
	--dbpass=$MARIADB_PASSWORD \
	--dbhost=$MARIADB_HOST \
	--allow-root

wp config set "WP_REDIS_HOST" "redis" --allow-root
wp config set "WP_REDIS_PORT" "6379" --allow-root

wp core install \
  --url=$DOMAIN \
  --title='ft_wordpress' \
	--admin_name=$WP_ADMIN_USER \
	--admin_password=$WP_ADMIN_PASSWORD \
	--admin_email=$WP_ADMIN_EMAIL \
	--allow-root

wp user create $WP_USER \
	--role=author \
	--user_pass=$WP_PASSWORD \
	--user_email=$WP_EMAIL \
	--allow-root

wp plugin install redis-cache --activate --allow-root

mkdir -p /run/php/
wp redis enable --allow-root
/usr/sbin/php-fpm7.4 -F
