#!/usr/bin/make -f

SHELL:=$(shell which bash)

CONTAINER:=juno

clean:
	@docker-compose down

build:
	@docker-compose up -d --build

start: build

shell: start
	@docker exec -it $(CONTAINER) bash

install-pip:
	@if ! which ansible &>/dev/null ; then \
		pip install $(shell test -z "$$VIRTUAL_ENV" || echo "--user") -r requirements.txt ; \
	fi

test: start install-pip
	@make -C tests/ test
