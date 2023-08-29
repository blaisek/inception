FROM debian:11.7

SHELL ["/bin/bash", "-c"]

RUN apt-get update -yq
RUN apt-get install nginx -yq
RUN apt-get install openssl -yq
RUN apt-get install iputils-ping -yq

RUN mkdir -p /etc/ssl/private/
RUN mkdir -p /etc/ssl/certs/
RUN mkdir -p /var/www/html/
RUN mkdir -p /logs/

RUN openssl req -x509 \
	-sha256 -days 365 \
	-nodes \
	-newkey rsa:2048 -keyout /etc/ssl/private/btchiman.42lausanne.fr.key \
	-subj "/CN=btchiman.42lausanne.fr/C=CH/ST=GE/L=GENEVA" -out /etc/ssl/certs/btchiman.42lausanne.fr.crt

COPY /conf/nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]
