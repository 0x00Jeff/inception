#!/bin/bash

# no need to rerun all of this if it was already initialized
if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then

	# start mariadb and wait till the service is ready
	service mariadb start
	until mariadb-admin ping --silent 2>/dev/null; do
	    sleep 1
	done

	# create the db, mysql user, give him privs on the db, and change the root password

	mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
	mariadb -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
	mariadb -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO \`${MYSQL_USER}\`@'%';"

	mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
	mariadb -e "FLUSH PRIVILEGES;"

	# shutdown and start in foreground mode

	mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown
fi

mysqld_safe --port=3306 --bind-address=0.0.0.0 --datadir='/var/lib/mysql'
