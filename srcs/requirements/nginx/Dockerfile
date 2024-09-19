FROM debian:12

RUN apt-get update -y && apt-get install nginx openssl -y iputils-ping vim

RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/conf.d/afatimi.crt -keyout /etc/nginx/conf.d/afatimi.key -subj "/C=MR/ST=Morocco/L=kh/O=1337/OU=afatimi/CN=afatimi.42.fr/"

COPY conf/nginx.conf /etc/nginx/sites-available/default

COPY index.html /var/www/html

RUN chmod +r -R /var/www/html*

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
