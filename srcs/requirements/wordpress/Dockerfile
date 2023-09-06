# Dockerfile for WordPress service

FROM debian:11

# Install necessary packages
SHELL ["/bin/bash", "-c"]

RUN apt-get update -yq
RUN apt-get install php-fpm -yq
RUN apt-get install php-mysql -yq
RUN apt-get install mariadb-client -yq
RUN apt-get install curl -yq
RUN apt-get install vim -yq
RUN apt-get install iputils-ping -yq

COPY /conf/www.conf /etc/php/7.4/fpm/pool.d
COPY /tools/create_wordpress.sh .

RUN chmod +x create_wordpress.sh

CMD ["bash", "create_wordpress.sh"]