/** Remove default mysql user **/
DROP DATABASE IF EXISTS maria;
DELETE FROM mysql.db WHERE Db='maria';
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

/** Setup mysql root password **/
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$MARIADB_ROOT_PASSWORD');

/** Create database and user for the project */
CREATE USER IF NOT EXISTS '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_PASSWORD';
GRANT ALL PRIVILEGES ON '$MARIADB_NAME'.* TO '$MARIADB_USER@''%';

/** Apply changes **/
FLUSH PRIVILEGES;