FROM debian:bullseye

RUN mkdir -p /var/www/html

RUN apt update -y && apt install -y php \
	php-fpm php-mysql curl && \
	apt clean && \
	rm -rf /var/lib/apt/lists/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar


COPY tools/script.sh /usr/local/bin/

RUN chmod 755 /var/www/html \
	&& chown -R www-data:www-data /var/www/html \
	&& chmod +x wp-cli.phar \
	&& chmod +x /usr/local/bin/script.sh \
	&& mv wp-cli.phar /usr/local/bin/wp

COPY conf/wp-config.php /

ENV WP_CLI_ALLOW_ROOT=1

CMD ["bash", "/usr/local/bin/script.sh"]
