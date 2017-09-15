IMAGE_NAME=alpine-nginx-playground

all: build run

build: shutdown
	-@docker build -t $(IMAGE_NAME) .

shutdown: stop
	-@docker rmi $(IMAGE_NAME)

run:
	-@docker run --name some-nginx -d -p 8080:80 $(IMAGE_NAME)
stop:
	-@docker ps | grep $(IMAGE_NAME) | awk '{ print $$1 }' | xargs docker stop > /dev/null
	-@docker ps -a | grep $(IMAGE_NAME) | awk '{ print $$1 }' | xargs docker rm > /dev/null
