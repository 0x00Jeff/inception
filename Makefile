all: build up

build:
	docker-compose -f ./srcs/docker-compose.yml build
up:
	docker-compose -f ./srcs/docker-compose.yml up

down:
	docker-compose -f ./srcs/docker-compose.yml down -v -t 1
stop:
	docker-compose -f ./srcs/docker-compose.yml stop -t 1
clean:
	docker-compose -f ./srcs/docker-compose.yml down -v -t 1
prune:
	docker system prune -a -f

re: clean all
