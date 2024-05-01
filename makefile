SHELL=/bin/bash

USERID := $(shell id -u)
GROUPID := $(shell id -g)

build_dev:
	echo "Build docker development"
	sudo docker compose build --build-arg GROUPID=$(GROUPID) --build-arg USERID=$(USERID) app

start_dev: build_dev
	echo "Start development"
	sudo docker compose up -d
