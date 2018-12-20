#!/usr/bin/make -f

HOST_SELINUX:=$(shell if [ -e /sys/fs/selinux ]; then echo true ; else echo false ; fi)

install-deps:
	@ansible-galaxy install --force -p .ansible/galaxy-roles -r requirements.yml

test: install-deps
	@ANSIBLE_FORCE_COLOR=yes ansible-playbook -i inventory/hosts.yml -e host_selinux=$(HOST_SELINUX) playbook.yml
