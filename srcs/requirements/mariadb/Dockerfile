FROM debian:11.7

SHELL ["/bin/bash", "-c"]

RUN apt-get update -yq
RUN apt-get install systemctl -yq
RUN apt-get install mariadb-server -yq
RUN apt-get install iputils-ping -yq

RUN mkdir -p /run/mysqld /var/lib/mysql
COPY ./conf/custom.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/mariadb.sh .
RUN chmod +x mariadb.sh

# EXPOSE 3306

CMD ["bash", "/mariadb.sh"]
