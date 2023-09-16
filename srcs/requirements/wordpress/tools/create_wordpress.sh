#!/bin/bash

# Create Directory Structure
mkdir -p /var/www/btchiman.42.fr
cd /var/www/html/btchiman.42.fr

# Check if wp core download has already been done
if [ ! -e wp-config.php ]; then
  # Download and Install WP-CLI
  curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
  chmod +x wp-cli.phar
  mv wp-cli.phar /usr/local/bin/wp

  # Download WordPress Core
  wp core download --allow-root

  # Verify if wp core download was successful
  if [ $? -ne 0 ]; then
    echo "Error: WordPress core download failed."
    exit 1
  fi

  # Create WordPress Configuration File (wp-config.php)
  wp core config \
    --dbname="$MARIADB_NAME" \
    --dbuser="$MARIADB_USER" \
    --dbpass="$MARIADB_PASSWORD" \
    --dbhost="$MARIADB_HOST" \
    --allow-root

  # Verify the content of dbname and dbuser
  if [ -z "$MARIADB_NAME" ] || [ -z "$MARIADB_USER" ]; then
    echo "Error: Database name and user must be provided."
    exit 1
  fi

  # Continue with WordPress installation
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
fi

# Create necessary directory for PHP-FPM
mkdir -p /run/php/

# Start PHP-FPM
/usr/sbin/php-fpm7.4 -F
