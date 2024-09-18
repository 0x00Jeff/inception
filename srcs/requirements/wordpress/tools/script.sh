#!/bin/bash

# configure fpm to listen on the network

FPM_CONFIG="/etc/php/8.2/fpm/pool.d/www.conf"
sed -i 's|listen = /run/php/php8.2-fpm.sock|listen = 9000|g' "${FPM_CONFIG}"


# download wordpress
wp core download --path=/var/www/html/

# configure access to mariadb
WORDPRESS_SAMPLE_CONFIG="/var/www/html/wp-config-sample.php"
WORDPRESS_CONFIG="/var/www/html/wp-config.php"

cp ${WORDPRESS_SAMPLE_CONFIG} ${WORDPRESS_CONFIG}

sed -i "s|database_name_here|${MYSQL_DATABASE}|g" "${WORDPRESS_CONFIG}"
sed -i "s|username_here|${MYSQL_USER}|g" "${WORDPRESS_CONFIG}"
sed -i "s|password_here|${MYSQL_PASSWORD}|g" "${WORDPRESS_CONFIG}"
sed -i "s|localhost|${MY_MYSQL_HOST}|g" "${WORDPRESS_CONFIG}"


# install wordpress
wp core install --url=${WP_URL} --title=${WP_TITLE} --admin_user=${WP_ADMIN_USER} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL} --path=/var/www/html --skip-email

# download wordpress theme
#wp theme install codeify --activate --path=/var/www/html

service php8.2-fpm start

sleep infinity
