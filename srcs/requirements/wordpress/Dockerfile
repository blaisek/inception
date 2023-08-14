# Dockerfile for WordPress service

FROM debian:11.7

# Install necessary packages
RUN apt-get update && \
    apt-get install -y wget \
                       curl \
                       bash \
                       php7.4 \
                       php7.4-fpm \
                       php7.4-mysql \
                       php7.4-pdo \
                       php7.4-gd \
                       php7.4-cli \
                       php7.4-mbstring \
                       redis \
                       php-redis \
                       && rm -rf /var/lib/apt/lists/*

# Install wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && chmod +x wp-cli.phar \
  && mv wp-cli.phar /usr/local/bin/wp

# Copy the .conf to the html directory
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/

# Create folder to enable PHP-FPM start
RUN mkdir /run/php

# Copy the script, give permission to execute it
COPY ./tools/create_wordpress.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/create_wordpress.sh

# Set the entry point for the container
ENTRYPOINT ["/usr/local/bin/create_wordpress.sh"]

# Set the working directory
WORKDIR /var/www/html/

# Expose port 9000
EXPOSE 9000

# Launch PHP FPM in foreground and ignore daemonize from conf file (-F)
CMD ["/usr/sbin/php-fpm7.4", "-F"]
