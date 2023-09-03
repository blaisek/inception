#!/bin/bash

# Fonction pour afficher un message d'erreur et quitter le script en cas d'échec
function check_status {
  if [ $? -ne 0 ]; then
    echo "ERREUR: $1"
    exit 1
  fi
}

# Vérification et mise à jour de MariaDB
mysql_upgrade -u root -p"$MARIADB_ROOT_PASSWORD"
check_status "Échec de la mise à jour de MariaDB"

# Démarrage de MariaDB
mysqld --datadir=/var/lib/mysql &
pid=$!

# Attendre que MariaDB soit disponible
until mysqladmin -u root -p"$MARIADB_ROOT_PASSWORD" ping >/dev/null 2>&1; do
    sleep 1
done

# Création de la base de données WordPress et de l'utilisateur
mysql -u root -p"$MARIADB_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $MARIADB_NAME;"
check_status "Échec de la création de la base de données"

mysql -u root -p"$MARIADB_ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS '$MARIADB_USER' IDENTIFIED BY '$MARIADB_PASSWORD';"
check_status "Échec de la création de l'utilisateur"

mysql -u root -p"$MARIADB_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON $MARIADB_NAME.* TO '$MARIADB_USER';"
check_status "Échec de la définition des privilèges de l'utilisateur"

mysql -u root -p"$MARIADB_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"
check_status "Échec de l'actualisation des privilèges"

mysql -u root -p"$MARIADB_ROOT_PASSWORD" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ROOT_PASSWORD';"
check_status "Échec de la modification du mot de passe root"

# Arrêt propre de MariaDB
mysqladmin -u root -p"$MARIADB_ROOT_PASSWORD" shutdown
check_status "Échec de l'arrêt de MariaDB"

# Attente du processus de MariaDB pour se terminer
wait "$pid"

# Redémarrage de MariaDB
exec mysqld --datadir=/var/lib/mysql
