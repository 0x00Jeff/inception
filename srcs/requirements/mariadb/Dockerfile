FROM debian:12

RUN apt-get update -y && apt-get -y install mariadb-server iputils-ping

#COPY conf/50-server.conf /etc/mysql/mariadb.conf.d/

EXPOSE 3306

COPY tools/mariadb_init.sh /usr/bin/

RUN chmod +x /usr/bin/mariadb_init.sh

RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld && chmod 777 /var/run/mysqld

HEALTHCHECK --start-period=5m CMD mariadb -e 'SELECT @@datadir;' || exit 1

ENV DOMAIN_NAME=afatimi.42.fr
ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_USER=wordpress
ENV MYSQL_PASSWORD=wordpress
#ENV MYSQL_ROOT_PASSWORD=123
ENV MYSQL_DATABASE=wordpressdb
ENV MYSQL_HOST=mariadb

ENTRYPOINT ["/usr/bin/mariadb_init.sh"]

#CMD ["service mysql start"]
CMD ["mysqld", "--bind-address=0.0.0.0"]
