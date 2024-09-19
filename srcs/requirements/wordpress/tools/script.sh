#!/bin/bash

# configure fpm to listen on the network

FPM_CONFIG="/etc/php/8.2/fpm/pool.d/www.conf"
sed -i 's|listen = /run/php/php8.2-fpm.sock|listen = 9000|g' "${FPM_CONFIG}"

# download wordpress
wp core download --path=/var/www/html/

# copy config file
WORDPRESS_CONFIG="/var/www/html/wp-config.php"
mv /wp-config.php ${WORDPRESS_CONFIG}

# set the right config for wordpress
sed -i "s|database_name_here|${MYSQL_DATABASE}|g" "${WORDPRESS_CONFIG}"
sed -i "s|username_here|${MYSQL_USER}|g" "${WORDPRESS_CONFIG}"
sed -i "s|password_here|${MYSQL_PASSWORD}|g" "${WORDPRESS_CONFIG}"
sed -i "s|localhost|${MY_MYSQL_HOST}|g" "${WORDPRESS_CONFIG}"
sed -i "s|wp_home_here|${WP_HOME}|g" "${WORDPRESS_CONFIG}"
sed -i "s|wp_siteurl_here|${WP_SITEURL}|g" "${WORDPRESS_CONFIG}"

# install wordpress
wp core install --url=${WP_URL} --title=${WP_TITLE} --admin_user=${WP_ADMIN_USER} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL} --path=/var/www/html --skip-email
wp user create ${WP_USER} ${WP_EMAIL} --role=author --user_pass=${WP_PASSWORD} --path=/var/www/html

# download wordpress theme
#wp theme install codeify --activate --path=/var/www/html

php-fpm8.2 -F
