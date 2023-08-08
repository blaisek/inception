FROM debian:11.7

# Install all the required programs
RUN apt-get update && \
    apt-get install -y nginx openssl

# Create directory for nginx SSL and generate a self-signed SSL certificate
RUN mkdir /etc/nginx/ssl && \
    openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
    -out /etc/nginx/ssl/vbachele.crt \
    -keyout /etc/nginx/ssl/vbachele.key \
    -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=vbachele/CN=vbachele/"

# Copy nginx configuration file
COPY ./conf/nginx.conf /etc/nginx/conf.d

# Create directory for nginx to store runtime files
RUN mkdir -p /run/nginx

# Expose only port 443 for SSL
EXPOSE 443

# Start nginx
CMD ["nginx", "-g", "daemon off;"]