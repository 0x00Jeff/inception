FROM debian:12

RUN apt-get update -y && apt-get -y install mariadb-server

COPY conf/my.cnf /etc/mysql/my.cnf

EXPOSE 3306

COPY tools/mariadb_init.sh /usr/bin/
#COPY ./conf/wordpress.sql /usr/bin/

RUN chmod +x /usr/bin/mariadb_init.sh
#RUN chmod +x /usr/bin/wordpress.sql

RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld && chmod 777 /var/run/mysqld

HEALTHCHECK --start-period=5m CMD mariadb -e 'SELECT @@datadir;' || exit 1


ENTRYPOINT ["/usr/bin/mariadb_init.sh"]

#CMD ["service mysql start"]
CMD ["mysqld", "--bind-address=0.0.0.0"]
