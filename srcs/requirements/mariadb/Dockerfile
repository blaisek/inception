FROM debian:bullseye

WORKDIR /app

RUN apt-get -y update
RUN apt-get install -y mariadb-server

COPY ./conf/maria.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools/mariadb.sh /app/tools/mariadb.sh

RUN chmod 777 /app/tools/mariadb.sh

CMD ["/app/tools/maria.sh" ]