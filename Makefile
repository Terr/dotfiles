MAKEFILE_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
NPROC ?= $(shell nproc --all)

AUTOMAKE = /usr/bin/automake
BAT = $(HOME)/.cargo/bin/bat
CARGO = $(HOME)/.cargo/bin/cargo
FSELECT = $(HOME)/.cargo/bin/fselect
RIPGREP = $(HOME)/.cargo/bin/rg
TMUX = /usr/local/bin/tmux

.PHONY: submodules build-tools

all: submodules $(CARGO) $(RIPGREP) $(BAT) $(FSELECT) $(TMUX)

submodules:
	# git submodule update --init

$(CARGO): build-tools
	$(MAKEFILE_DIR)/scripts/rustup.sh -y

$(RIPGREP): $(CARGO)
	$(CARGO) install --force ripgrep

$(BAT): $(CARGO)
	$(CARGO) install --force bat

$(FSELECT): $(CARGO)
	$(CARGO) install --force fselect

.ONESHELL:
$(TMUX): build-tools
	sudo apt install -y \
		libncurses5-dev \
		libevent-dev
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

build-tools:
	sudo apt-get install -y \
		automake \
		pkg-config \
		gcc
