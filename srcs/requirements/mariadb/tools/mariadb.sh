#!/bin/sh

# -e <=> --execute

service mysql start;
mysql --execute "CREATE DATABASE IF NOT EXISTS \`${MARIADB_NAME}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${MARIADB_USER}\`@'localhost' IDENTIFIED BY '${MARIADB_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${MARIADB_NAME}\`.* TO \`${MARIADB_USER}\`@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"
# restart mariadb
mysqladmin -u root -p$MARIADB_ROOT_PASSWORD shutdown
exec mysqld_safe