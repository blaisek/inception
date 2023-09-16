FROM debian:bullseye


RUN apt-get -y update
RUN apt-get install -y mariadb-server \
mariadb-client \
vim \
&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/mysqld \
&& chown -R mysql:mysql /var/run/mysqld \
&& chmod 777 /var/run/mysqld

COPY ./conf/maria.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/mariadb.sh /tools/mariadb.sh

RUN chmod 777 /tools/mariadb.sh

ENTRYPOINT ["bash", "tools/mariadb.sh"]