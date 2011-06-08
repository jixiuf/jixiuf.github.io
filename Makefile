# -*- coding:utf-8 -*-
.PHONY: build
recent:
	make -C ./build recent
all:
	make -C ./build all

preview:
	make -C ./build preview
run-emacs:
	make -C ./build run-emacs
