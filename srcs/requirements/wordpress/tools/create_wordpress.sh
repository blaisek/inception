# !/bin/bash

mkdir -p /var/www/html
cd /var/www/html

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

wp core download --allow-root

wp core config \
	--dbname=$MARIADB_DB_NAME \
	--dbuser=$MARIADB_USER \
	--dbpass=$MARIADB_PASS \
	--dbhost=mariadb \
	--allow-root

wp config set "WP_REDIS_HOST" "redis" --allow-root
wp config set "WP_REDIS_PORT" "6379" --allow-root

wp core install \
	--admin_name=$WP_ADMIN_USER \
	--admin_password=$WP_ADMIN_PASSWORD \
	--allow-root

wp user create toto \
	--role=author \
	--user_pass=1234 \
	--allow-root

wp plugin install redis-cache --activate --allow-root

mkdir -p /run/php/
wp redis enable --allow-root
/usr/sbin/php-fpm7.4 -F