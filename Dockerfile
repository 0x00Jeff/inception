FROM debian:stable

RUN apt-get update -y && apt-get install nginx openssl -y # ncat curl less certbot -y

#RUN cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.back

RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/conf.d/afatimi.crt -keyout /etc/nginx/conf.d/afatimi.key -subj "/C=MR/ST=Morocco/L=kh/O=1337/OU=afatimi/CN=afatimi/"

COPY conf/nginx.conf /etc/nginx/nginx.conf

COPY index.html /var/www/html/

RUN chmod +r -Rv /var/www/html*

EXPOSE 8080

#EXPOSE 443

#EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]