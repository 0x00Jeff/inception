FROM debian:stable

RUN apt-get update -y && apt-get install nginx -y # ncat curl less certbot -y

COPY index.html /var/www/html/

RUN cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.back

RUN chmod +r -Rv /var/www/html*

COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 8080

#EXPOSE 443

#EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
