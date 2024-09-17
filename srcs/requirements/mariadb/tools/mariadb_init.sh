#!/bin/sh

#sleep infinity

sed -i 's/^bind-address\s*=.*/bind-address = 0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf

/etc/init.d/mariadb start

mysql_install_db

mysql_secure_installation -h localhost << EOF > /dev/null 2>&1

n
y
$MYSQL_ROOT_PASSWORD
$MYSQL_ROOT_PASSWORD
y
n
y
y
EOF

# Create SQL script
cat <<EOF > db1.sql
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
EOF

#SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$MYSQL_ROOT_PASSWORD');

# Execute SQL script
mariadb -u root -p"$MYSQL_ROOT_PASSWORD" -h localhost < db1.sql

/etc/init.d/mariadb stop

exec "$@"
