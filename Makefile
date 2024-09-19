all: build up

build:
	docker-compose -f ./srcs/docker-compose.yml build

up:
	docker-compose -f ./srcs/docker-compose.yml up

down:
	docker-compose -f ./srcs/docker-compose.yml down -v -t 1

clean: down
	# TODO : find a better solution for this later!!!
	rm -rf srcs/data/wordpress/*
	docker system prune -a -f

re: down all
