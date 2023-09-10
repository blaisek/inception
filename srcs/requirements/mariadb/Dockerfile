FROM alpine:3.17

LABEL maintainer="btchiman@student.42lausanne.ch"

# Install mariadb
RUN apk update && apk upgrade \
    && apk add --no-cache --quiet --update \
    	   mariadb mariadb-client vim

RUN mkdir -p /var/lib/mysqld /run/mysqld

# Copy the database configuration file
COPY ./conf/create_db.sql /tmp/create_db.sql

# Copy the server configuration file
COPY ./conf/maria.cnf /etc/my.cnf.d/

# Copy the script to create the database
COPY ./tools/mariadb.sh /tmp/mariadb.sh
RUN chmod +x /tmp/mariadb.sh

# Run the entrypoint script
ENTRYPOINT ["sh", "/tmp/mariadb.sh"]