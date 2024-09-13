#!/bin/sh

mysql_install_db

/etc/init.d/mariadb start

# Set root option so that connexion without root password is not possible
	echo "worked" > /tmp/check

#mysql_secure_installation << _EOF_

#Y
#rootpass
#rootpass
#Y
#n
#Y
#Y
#_EOF_

# imitate mysql_secure_installation behaviour interactively
# Make sure that NOBODY can access the server without a password
#
mysql -e "UPDATE mysql.user SET Password = PASSWORD('root') WHERE User = 'root'"
# Kill the anonymous users
mysql -e "DROP USER IF EXISTS ''@'localhost'"
# Because our hostname varies we'll use some Bash magic here.
mysql -e "DROP USER IF EXISTS ''@'$(hostname)'"
# Kill off the demo database
mysql -e "DROP DATABASE IF EXISTS test"
# Make our changes take effect
mysql -e "FLUSH PRIVILEGES"
# Any subsequent tries to run queries this way will get access denied because lack of usr/pwd param

#Add a root user on 127.0.0.1 to allow remote connexion
#Flush privileges allow to your sql tables to be updated automatically when you modify it
#mysql -uroot launch mysql command line client

echo "CREATE DATABASE IF NOT EXISTS WORDPRESSDB" | mysql -uroot

echo "CREATE USER 'wordpress'@localhost IDENTIFIED BY 'wordpresspass';" | mysql -uroot
echo "GRANT ALL PRIVILEGES ON WORDPRESSDB.* TO 'wordpress'@localhost IDENTIFIED BY 'wordpresspass'" | mysql -uroot
ALTER USER 'root'@'localhost' IDENTIFIED BY '123';
mysql -e "FLUSH PRIVILEGES"

#echo "CREATE DATABASE IF NOT EXISTS wordpress; GRANT ALL ON wordpress.* TO 'wordpress'@'%'; FLUSH PRIVILEGES;" | mysql -u root

#Import database in the mysql command line
mysql -uroot WORDPRESSDB < /usr/bin/wordpress.sql

/etc/init.d/mariadb stop

echo "now executing \'$@\'" > /tmp/check_me

exec "$@"
