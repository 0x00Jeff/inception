FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y mariadb-server netcat iputils-ping vim

COPY tools/mariadb_init.sh /bin/mariadb_init.sh

RUN chmod +x /bin/mariadb_init.sh

ENTRYPOINT ["/bin/mariadb_init.sh"]
