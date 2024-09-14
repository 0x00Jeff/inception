#!/bin/sh

mysql_install_db

/etc/init.d/mariadb start

mysql_secure_installation << EOF > /dev/null 2>&1
n
$MYSQL_ROOT_PASSWORD
$MYSQL_ROOT_PASSWORD
y
n
n
n
n
EOF

# Create SQL script
cat <<EOF > db1.sql
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
EOF

# Execute SQL script
mariadb -u root -p"$MYSQL_ROOT_PASSWORD" < db1.sql
rm db1.sql

#mysql -e "UPDATE mysql.user SET Password = PASSWORD('$MYSQL_ROOT_PASSWORD') WHERE User = 'root'"
# TODO : why the fuck does restricting root doesn't work ???
#echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" | mysql -uroot
#echo "FLUSH PRIVILEGES" | mysql -uroot

# imitate mysql_secure_installation behaviour interactively
# Make sure that NOBODY can access the server without a password
#
# Kill the anonymous users
#mysql -e "DROP USER IF EXISTS ''@'localhost'"
# Because our hostname varies we'll use some Bash magic here.
#mysql -e "DROP USER IF EXISTS ''@'$(hostname)'"
## Kill off the demo database
#mysql -e "DROP DATABASE IF EXISTS test"
## Make our changes take effect
#mysql -e "FLUSH PRIVILEGES"
# Any subsequent tries to run queries this way will get access denied because lack of usr/pwd param

#echo "CREATE DATABASE IF NOT EXISTS WORDPRESSDB" | mysql -uroot

#echo "CREATE USER 'wordpress'@localhost IDENTIFIED BY 'wordpresspass';" | mysql -uroot
#echo "GRANT ALL PRIVILEGES ON WORDPRESSDB.* TO 'wordpress'@localhost IDENTIFIED BY 'wordpresspass'" | mysql -uroot
#ALTER USER 'root'@'localhost' IDENTIFIED BY '123';
#mysql -e "FLUSH PRIVILEGES"

/etc/init.d/mariadb stop

exec "$@"
