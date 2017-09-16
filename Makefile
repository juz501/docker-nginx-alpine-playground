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

sasswatch: node_modules/node-sass/bin/node-sass
	node node_modules/node-sass/bin/node-sass --output dist/css --watch assets/scss/styles.scss

images: dist/images/*

dist/images/*:
	mkdir -p dist/images
	cp assets/images/* dist/images/


node_modules/node-sass/bin/node-sass:
	mkdir -p dist/css
	npm prune && npm install