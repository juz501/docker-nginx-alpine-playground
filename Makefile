IMAGE_NAME=alpine-nginx-playground

all: build run

build: shutdown
	-@docker build -t $(IMAGE_NAME) .

shutdown: stop
	-@docker rmi $(IMAGE_NAME)

run:
	-@docker-compose up -d

stop:
	-@docker-compose down
	-@docker ps | grep $(IMAGE_NAME) | awk '{ print $$1 }' | xargs docker stop > /dev/null
	-@docker ps -a | grep $(IMAGE_NAME) | awk '{ print $$1 }' | xargs docker rm > /dev/null

images: dist/images/*

dist/images/*:
	mkdir -p dist/images
	cp assets/images/* dist/images/