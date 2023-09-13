#!/bin/sh

# Check if MariaDB is initialized
if [ ! -f /var/lib/mysql/initialized ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
    touch /var/lib/mysql/initialized
fi

mkdir -p /run/mysql
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql

# Start MariaDB
mysqld --user=mysql --datadir=/var/lib/mysql &

pid=$!

# Wait for MariaDB to become available
until mysqladmin -u root -p${MARIADB_ROOT_PASSWORD} ping >/dev/null 2>&1; do
    sleep 1
done

# Check if root password has already been set
if [ ! -f /var/lib/mysql/root_password_set ]; then
    mysql -u root -p${MARIADB_ROOT_PASSWORD} -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';"
    touch /var/lib/mysql/root_password_set
fi

# create wordpress database and user
# modify user privileges on the database
mysql -u root -p${MARIADB_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS ${MARIADB_NAME};"
mysql -u root -p${MARIADB_ROOT_PASSWORD} -e "CREATE USER IF NOT EXISTS '${MARIADB_USER}' IDENTIFIED BY '${MARIADB_PASSWORD}';"
mysql -u root -p${MARIADB_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON ${MARIADB_NAME}.* TO '${MARIADB_USER}';"
mysql -u root -p${MARIADB_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

# Gracefully stop MariaDB
mysqladmin -u root -p${MARIADB_ROOT_PASSWORD} shutdown

# Wait for MariaDB to stop
wait "$pid"

# Start MariaDB again in the foreground
exec mysqld --user=mysql
