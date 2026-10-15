FROM debian:bookworm

RUN apt-get update -y

RUN apt-get install -y mariadb-server netcat-openbsd && \
	apt clean && \
	rm -rf /var/lib/apt/lists/*

COPY tools/mariadb_init.sh /bin/mariadb_init.sh

RUN chmod +x /bin/mariadb_init.sh

ENTRYPOINT ["/bin/mariadb_init.sh"]
