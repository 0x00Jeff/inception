FROM debian:12

RUN apt update -y && apt install -y php \
	php-cli php-fpm php-mysql \
	php-json php-opcache php-mbstring \
	php-xml php-gd php-curl wordpress curl ncat iputils-ping vim && \
	apt clean && \
    rm -rf /var/lib/apt/lists/* && \
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod 755 /var/www/html \
	&& chown -R www-data:www-data /var/www/html \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

COPY tools/script.sh /usr/local/bin/

COPY conf/wp-config.php /

ENV WP_CLI_ALLOW_ROOT=1

EXPOSE 9000

CMD ["bash", "/usr/local/bin/script.sh"]
