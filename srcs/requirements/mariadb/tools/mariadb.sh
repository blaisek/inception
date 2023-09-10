#!/bin/bash

#mysql_install_db --datadir=/var/lib/mysql

# Changer les autorisations du répertoire de données
#chown -R mysql:mysql /var/lib/mysql

# Créer le répertoire /run/mysqld s'il n'existe pas
#mkdir -p /run/mysqld

# Changer les autorisations du répertoire /run/mysqld
#chown -R mysql:mysql /run/mysqld

#mysqld --datadir=/var/lib/mysql &

#pid=$!

# Attendre que MariaDB soit disponible
until mysqladmin -u root -p$MARIADB_ROOT_PASSWORD ping >/dev/null 2>&1; do
    sleep 1
done

# Créer la base de données WordPress et l'utilisateur
# Modifier les privilèges de l'utilisateur sur la base de données
mysql -u root -p$MARIADB_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS "test";"
mysql -u root -p$MARIADB_ROOT_PASSWORD -e "CREATE USER IF NOT EXISTS '$MARIADB_USER' IDENTIFIED BY '$MARIADB_PASSWORD';"
mysql -u root -p$MARIADB_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON *.* TO '$MARIADB_USER';"
mysql -u root -p$MARIADB_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"
mysql -u root -p$MARIADB_ROOT_PASSWORD -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ROOT_PASSWORD';"

# Arrêter et redémarrer la base de données
mysqladmin -u root -p$MARIADB_ROOT_PASSWORD shutdown

exec mysqld_safe
