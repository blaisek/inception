#!/bin/bash

service mariadb start

sleep 10

mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MARIADB_NAME}\`;"

mariadb -e "CREATE USER IF NOT EXISTS \`${MARIADB_USER}\`@'%'\
		 IDENTIFIED BY '${MARIADB_PASSWORD}';"

mariadb -e "GRANT ALL PRIVILEGES ON \`${MARIADB_NAME}\`.* \
		TO \`${MARIADB_USER}\`@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';"

mariadb -e "CREATE USER IF NOT EXISTS \`root\`@'%'\
		 IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';"

mariadb -e "FLUSH PRIVILEGES;"

# service mariadb stop

mysqladmin -u root -p${MARIADB_ROOT_PASSWORD} shutdown


exec mysqld_safe #run in the foreground
