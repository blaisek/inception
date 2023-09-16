FROM debian:bullseye


RUN apt-get -y update
RUN apt-get install -y mariadb-server

COPY ./conf/maria.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/mariadb.sh /tools/mariadb.sh

RUN chmod 777 /tools/mariadb.sh

CMD ["/tools/mariadb.sh" ]