FROM debian:11.7

# Install mariadb and remove lists of downloaded packages
# to save space in the final image.
RUN apt-get update && \
    apt-get install -y mariadb-server \
                       mariadb-client \
                       vim && \
    rm -rf /var/lib/apt/lists/*

# Allow to run the daemon of MySQL
# Purge and re-create /var/lib/mysql with appropriate ownership
# Ensure that /var/run/mysqld (used for socket and lock files)
# is writable regardless of the UID our mysqld instance ends up having at runtime
RUN mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld && \
    chmod 777 /var/run/mysqld

EXPOSE 3306

# Copy of the .sh and .sql files into the /bin directory of the container
# to be able to run the program
# Give the right to execute + launch the .sh
COPY ./tools/mariadb.sh /usr/local/bin/
COPY ./conf/maria.cnf /etc/mysql/mariadb.conf.d/
RUN chmod +x /usr/local/bin/mariadb.sh
RUN chmod +x /usr/local/bin/wordpress.sql

ENTRYPOINT [ "/usr/local/bin/mariadb.sh" ]

# Command to launch mariadb and enable the database
# to listen globally - this can also be put in a mysqldump.cnf file
CMD ["mysqld", "--bind-address=0.0.0.0"]
