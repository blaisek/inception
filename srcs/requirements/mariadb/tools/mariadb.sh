#!/bin/bash

mysql_install_db  --datadir=/var/lib/mysql

mkdir -p /run/mysql
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql

mysqld  --datadir=/var/lib/mysql &

pid=$!

# Wait for MariaDB to become available
until mysqladmin -u root -p$MYSQL_ROOT_PASSWORD ping >/dev/null 2>&1; do
    sleep 1
done

# create wordpress database and user
# modify user privileges on the database
mysql -u root -p$MARIADB_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS $MARIADB_NAME;"
mysql -u root -p$MARIADB_ROOT_PASSWORD -e "CREATE USER IF NOT EXISTS '$MARIADB_USER' IDENTIFIED BY '$MARIADB_PASSWORD';"
mysql -u root -p$MARIADB_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON *.* TO '$MARIADB_USER';"
mysql -u root -p$MARIADB_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"
mysql -u root -p$MARIADB_ROOT_PASSWORD -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ROOT_PASSWORD';"

# affiche le contenu des variables d'environnement
echo -e "\n${GREY}MARIADB_ROOT_PASSWORD=$MARIADB_ROOT_PASSWORD${NC}"
echo -e "\n${GREY}MARIADB_PASSWORD=$MARIADB_PASSWORD${NC}"
echo -e "\n${GREY}MARIADB_NAME=$MARIADB_NAME${NC}"
echo -e "\n${GREY}MARIADB_USER=$MARIADB_USER${NC}"

# kill and restart database
kill "$pid"
wait "$pid"
exec mysqld --user=$MARIADB_USER
