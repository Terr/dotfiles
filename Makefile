MAKEFILE_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
NPROC ?= $(shell nproc --all)

AUTOMAKE = /usr/bin/automake
BAT = $(HOME)/.cargo/bin/bat
CARGO = $(HOME)/.cargo/bin/cargo
FSELECT = $(HOME)/.cargo/bin/fselect
RIPGREP = $(HOME)/.cargo/bin/rg
TMUX = /usr/local/bin/tmux

.PHONY: submodules

all: submodules $(CARGO) $(RIPGREP) $(BAT) $(FSELECT) $(TMUX)

submodules:
	git submodule update --init

$(CARGO): 
	$(MAKEFILE_DIR)/scripts/rustup.sh

$(RIPGREP): $(CARGO)
	cargo install ripgrep

$(BAT): $(CARGO)
	cargo install bat

$(FSELECT): $(CARGO)
	cargo install fselect

.ONESHELL:
$(TMUX): $(AUTOMAKE)
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

$(AUTOMAKE):
	sudo apt-get install -y automake
