all: build up

build:
	-mkdir -p /home/${USER}/data/wordpress
	-mkdir -p /home/${USER}/data/mariadb
	docker-compose -f ./srcs/docker-compose.yml build

up:
	-mkdir -p /home/${USER}/data/wordpress
	-mkdir -p /home/${USER}/data/mariadb
	docker-compose -f ./srcs/docker-compose.yml up

down:
	docker-compose -f ./srcs/docker-compose.yml down -v -t 1

clean: down
	rm -rf /home/${USER}/data/wordpress/*
	rm -rf /home/${USER}/data/mariadb/*

prune: clean
	docker system prune -a -f

re: down all
