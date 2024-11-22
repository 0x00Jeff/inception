FROM debian:bullseye

RUN apt-get update -y

RUN apt-get install -y mariadb-server netcat && \
	apt clean && \
	rm -rf /var/lib/apt/lists/*

COPY tools/mariadb_init.sh /bin/mariadb_init.sh

RUN chmod +x /bin/mariadb_init.sh

ENTRYPOINT ["/bin/mariadb_init.sh"]
