#!/bin/bash

source ./srcs/.env

mysql_install_db --user=mysql --datadir=/var/lib/mysql

mkdir -p /run/mysql
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql

mysqld --user=$MYSQL_USER --datadir=/var/lib/mysql --dbhost=$MYSQL_HOST &

pid=$!

# Wait for MariaDB to become available
until mysqladmin -u root -p$MYSQL_ROOT_PASSWORD ping >/dev/null 2>&1; do
    sleep 1
done

# create wordpress database and user
# modify user privileges on the database
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE USER IF NOT EXISTS '$MYSQL_USER' IDENTIFIED BY '$MYSQL_PASSWORD';"
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER';"
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"
mysql -u root -p$MYSQL_ROOT_PASSWOR -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"

# kill and restart database
kill "$pid"
wait "$pid"
exec mysqld --user=$MYSQL_USER
