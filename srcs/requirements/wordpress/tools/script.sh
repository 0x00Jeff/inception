#!/bin/bash

## configure fpm to listen on the network

# detect the installed php version
PHP_VER=$(ls /etc/php/)

# make php-fpm listen on the network instead of a local socket file
FPM_CONFIG="/etc/php/${PHP_VER}/fpm/pool.d/www.conf"
sed -i "s|listen = /run/php/php${PHP_VER}-fpm.sock|listen = 9000|g" "${FPM_CONFIG}"

# copy a wp-config.php template file and fill it up from the .env
WORDPRESS_CONFIG="/var/www/html/wp-config.php"
cp /wp-config.php ${WORDPRESS_CONFIG}
chmod 644 ${WORDPRESS_CONFIG}

# set the right config for wordpress
sed -i "s|database_name_here|${MYSQL_DATABASE}|g" "${WORDPRESS_CONFIG}"
sed -i "s|username_here|${MYSQL_USER}|g" "${WORDPRESS_CONFIG}"
sed -i "s|password_here|${MYSQL_PASSWORD}|g" "${WORDPRESS_CONFIG}"
sed -i "s|localhost|${MY_MYSQL_HOST}|g" "${WORDPRESS_CONFIG}"
#sed -i "s|wp_home_here|${WP_HOME}|g" "${WORDPRESS_CONFIG}"
#sed -i "s|wp_siteurl_here|${WP_SITEURL}|g" "${WORDPRESS_CONFIG}"

# download wordpress if not downloaded already
if [ ! -f /var/www/html/wp-settings.php ]; then
        wp core download --path=/var/www/html/
fi

# install wordpress if not already installed
if ! wp core is-installed --path=/var/www/html 2>/dev/null; then
	wp core install --url="${WP_HOME}" --title="${WP_TITLE}" \
                --admin_user="${WP_ADMIN_USER}" --admin_password="${WP_ADMIN_PASSWORD}" \
                --admin_email="${WP_ADMIN_EMAIL}" --path=/var/www/html --skip-email
	wp user create "${WP_USER}" "${WP_EMAIL}" --role=author \
                --user_pass="${WP_PASSWORD}" --path=/var/www/html
fi

# created needed directories for php${PHP_VER}-fpm to run
service php${PHP_VER}-fpm start
service php${PHP_VER}-fpm stop

# always reset the perms in case of a rerun of so
chown -R www-data:www-data /var/www/html

# run php-fpm in the foreground
php-fpm${PHP_VER} -F
