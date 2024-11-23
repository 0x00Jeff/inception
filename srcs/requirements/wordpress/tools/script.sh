#!/bin/bash

# configure fpm to listen on the network

FPM_CONFIG="/etc/php/7.4/fpm/pool.d/www.conf"
sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 9000|g' "${FPM_CONFIG}"

# copy config file
WORDPRESS_CONFIG="/var/www/html/wp-config.php"
cp /wp-config.php ${WORDPRESS_CONFIG}

chmod 644 ${WORDPRESS_CONFIG}

# set the right config for wordpress
sed -i "s|database_name_here|${MYSQL_DATABASE}|g" "${WORDPRESS_CONFIG}"
sed -i "s|username_here|${MYSQL_USER}|g" "${WORDPRESS_CONFIG}"
sed -i "s|password_here|${MYSQL_PASSWORD}|g" "${WORDPRESS_CONFIG}"
sed -i "s|localhost|${MY_MYSQL_HOST}|g" "${WORDPRESS_CONFIG}"
sed -i "s|wp_home_here|${WP_HOME}|g" "${WORDPRESS_CONFIG}"
sed -i "s|wp_siteurl_here|${WP_SITEURL}|g" "${WORDPRESS_CONFIG}"

chown -R www-data:www-data /var/www/html

if [ ! -f /tmp/.done ]
then
	# download wordpress
	wp core download --path=/var/www/html/

	# install wordpress
	wp core install --url=${WP_URL} --title=${WP_TITLE} --admin_user=${WP_ADMIN_USER} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL} --path=/var/www/html --skip-email
	wp user create ${WP_USER} ${WP_EMAIL} --role=author --user_pass=${WP_PASSWORD} --path=/var/www/html

	# created needed directories for php7.4-fpm to run
	service php7.4-fpm start
	service php7.4-fpm stop

	touch /tmp/.done
fi

php-fpm7.4 -F
