FROM debian:stable

RUN apt-get update -y && apt-get install nginx ncat curl less -y

COPY index.html /usr/share/nginx/html/

RUN cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.back

#COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
