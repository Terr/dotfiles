MAKEFILE_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
NPROC ?= $(shell nproc --all)

.PHONY: cargo ripgrep tmux automake

all: cargo ripgrep tmux

cargo: 
	sh ${MAKEFILE_DIR}/scripts/rustup.sh

ripgrep:
	@if [ ! -x ${HOME}/.cargo/bin/cargo ]; then make cargo; fi
	cargo install ripgrep

.ONESHELL:
tmux: automake
	# Make a clone of my personal of tmux
	$(eval TMPDIR := $(shell mktemp --directory))
	git clone --depth 1 https://github.com/Terr/tmux.git ${TMPDIR}
	cd ${TMPDIR}
	./autogen.sh
	./configure 
	make -j${NPROC}
	 sudo make install
	cd -
	rm -rf ${TMPDIR}

automake:
	sudo apt-get install -y automake
