FROM debian:12

RUN apt-get update -y && apt-get -y install mariadb-server

COPY conf/my.cnf /etc/mysql/my.cnf

EXPOSE 3306

RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld && chmod 777 /var/run/mysqld

HEALTHCHECK --start-period=5m CMD mariadb -e 'SELECT @@datadir;' || exit 1

#CMD ["service mysql start"]
CMD ["mysqld", "--bind-address=0.0.0.0"]
