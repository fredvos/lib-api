.PHONY : migrations

DOCKER_USERNAME ?= mokolo-org
APPLICATION_NAME ?= lib-api
CWD ?= $(shell pwd)

build-dev :
	docker build --file Dockerfile.dev --tag ${DOCKER_USERNAME}/${APPLICATION_NAME}-dev:latest .

generate-models :
	./generatemodels

migrations :
	./runflyway migrate
	./runflyway info

migration-info :
	./runflyway info

run-dev :
	docker run -d --rm -it --name lib_api --hostname lib_api --network dev_database -p 9001:8080 --volume ${CWD}:/var/lib/lib-api ${DOCKER_USERNAME}/${APPLICATION_NAME}-dev:latest
	docker network connect dev_api lib_api

run-nodocker :
	python3 runserver.py

psql :
	./run-psql
