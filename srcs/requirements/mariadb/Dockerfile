# Utilisez l'image de base Debian 11
FROM debian:11

SHELL ["/bin/bash", "-c"]


RUN apt-get update -yq
RUN apt-get install mariadb-server -yq
RUN apt-get install iputils-ping -yq
RUN rm -rf /etc/mysql && mkdir /etc/mysql
RUN mkdir -p /run/mysqld /var/lib/mysql
COPY ./conf/maria.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/mariadb.sh .
RUN chmod +x mariadb.sh

CMD ["bash", "mariadb.sh"]
