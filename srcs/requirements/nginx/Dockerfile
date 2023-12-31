FROM alpine:3.17

LABEL maintainer="btchiman@student.42lausanne.ch"

ARG DOMAIN

# Install nginx
RUN apk update && apk upgrade \
    && apk add --no-cache --quiet --update \
    	   nginx openssl

# Expose port 443
EXPOSE 443

# Generate self-signed SSL certificate
RUN mkdir -p /etc/nginx/ssl/certs && \
	openssl req \
	# Generate a new certificate instead of a certificate request
	-x509 \
	# Days of validity
	-days 60 \
	# Algorithm of key
	-newkey rsa:4096 \
	# no encryption of private key (also no prompt). Should use -noenc instead
	-nodes \
	# Output file of the private key
	-keyout /etc/nginx/ssl/certs/${DOMAIN}.key \
	# Outut file of the public key
	-out /etc/nginx/ssl/certs/${DOMAIN}.crt \
	# Certificate details
	-subj "/CN=btchiman.42lausanne.fr/C=CH/ST=GE/L=GENEVA"

# Folder for the server configuration files
RUN mkdir -p /var/run/nginx

# Copy nginx configuration
COPY ./conf/nginx.conf /etc/nginx/http.d/default.conf

# Start nginx
CMD ["nginx", "-g", "daemon off;"]