FROM debian:bullseye

WORKDIR /app

COPY . .

RUN apt-get -y update
RUN apt-get install -y mariadb-server

COPY ./conf/maria.cnf /etc/mysql/mariadb.conf.d/


RUN chmod 777 /app/tools/mariadb.sh

CMD ["/app/tools/maria.sh" ]