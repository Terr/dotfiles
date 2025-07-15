MAKEFILE_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
NPROC ?= $(shell nproc --all)

IS_MACOS := $(shell if [ "`uname -s`" = "Darwin" ]; then echo 1; else echo 0; fi)
HAS_PACMAN := $(shell command -v pacman >/dev/null && echo 1 || echo 0)
HAS_APT := $(shell command -v apt-get >/dev/null && echo 1 || echo 0)
HAS_HOMEBREW := $(shell command -v brew >/dev/null && echo 1 || echo 0)

PYTHON := python3
WGET := wget

# ifeq ($(IS_MACOS), 1)
# 	PYTHON_VERSION := $(shell $(PYTHON) --version|grep --only-matching --regexp='\d\.\d')
# 	PYTHON_USER_BIN := $(HOME)/Library/Python/$(PYTHON_VERSION)/bin
# else
# 	PYTHON_USER_BIN := $(HOME)/.local/bin
# endif

PIPX_USER_BIN=$(HOME)/.local/bin

CARGO_BIN := $(HOME)/.cargo/bin

AUTOMAKE := /usr/bin/automake
BAT := $(CARGO_BIN)/bat
CARGO := $(CARGO_BIN)/cargo
FASD := $(HOME)/bin/fasd
FD := $(CARGO_BIN)/fd
FSELECT := $(CARGO_BIN)/fselect
FZF := $(HOME)/bin/fzf
GCC := /usr/bin/gcc
HEXYL := $(CARGO_BIN)/hexyl
LS_COLORS := $(HOME)/bin/LS_COLORS
RIPGREP := $(CARGO_BIN)/rg
SEMGREP := $(PIPX_USER_BIN)/semgrep
TMUX := /usr/local/bin/tmux
VIU := $(CARGO_BIN)/viu
ZSH_SYNTAX_HIGHLIGHTING := $(HOME)/bin/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

.PHONY: submodules

all: submodules \
	$(BAT) \
	$(CARGO) \
	$(FASD) \
	$(FD) \
	$(FSELECT) \
	$(FZF) \
	$(HEXYL) \
	$(LS_COLORS) \
	$(RIPGREP) \
	$(SEMGREP) \
	$(TMUX) \
	$(VIU) \
	$(ZSH_SYNTAX_HIGHLIGHTING)

submodules:
	git submodule update --init

bat: $(BAT)
$(BAT): $(CARGO)
	$(CARGO) install --force bat

cargo: $(CARGO)
$(CARGO): $(GCC)
	$(MAKEFILE_DIR)/home/bin/rustup.sh -y

fasd: $(FASD)
$(FASD):
	mkdir -p "$$HOME/bin"
	$(WGET) -O $$HOME/bin/fasd https://raw.githubusercontent.com/whjvenyl/fasd/c35874dac5491468ed746dda05d23c560d451dfa/fasd
	chmod u+x $$HOME/bin/fasd

fd: $(FD)
$(FD): $(CARGO)
	$(CARGO) install --force fd-find

fselect: $(FSELECT)
$(FSELECT): $(CARGO)
	$(CARGO) install --force fselect

fzf: $(FZF)
$(FZF):
	mkdir -p "$$HOME/bin"
	$(WGET) -O- https://github.com/junegunn/fzf/releases/download/v0.64.0/fzf-0.64.0-linux_amd64.tar.gz|tar -zx -C "$$HOME/bin" -f- fzf

hexyl: $(HEXYL)
$(HEXYL): $(CARGO)
	$(CARGO) install --force hexyl

ls-colors: $(LS_COLORS)
.ONESHELL:
$(LS_COLORS):
	mkdir -p "$$HOME/bin"
	if [ ! -e "${LS_COLORS}" -a -L "${LS_COLORS}" ]; then
		# Symlink is broken
		rm "${LS_COLORS}"
	fi
	ln -s "$(MAKEFILE_DIR)/home/bin/LS_COLORS" "${LS_COLORS}"
ifeq ($(IS_MACOS), 1)
	if [ ! -f "$$HOME/bin/dircolors" ]; then \
		brew install coreutils; \
		ln -s /usr/local/bin/gdircolors "$$HOME/bin/dircolors"; \
	fi
endif

ripgrep: $(RIPGREP)
$(RIPGREP): $(CARGO)
	$(CARGO) install --force ripgrep

semgrep: $(SEMGREP)
$(SEMGREP):
	pipx install semgrep

tmux: $(TMUX)
.ONESHELL:
$(TMUX): $(GCC)
	# Make a clone of my personal of tmux
	$(eval TMPDIR := $(shell mktemp --directory))
	git clone --depth 1 https://github.com/Terr/tmux.git ${TMPDIR}
	cd ${TMPDIR}
	./autogen.sh
	./configure 
	make -j${NPROC}
	sudo make install || su -c 'make install'
	cd -
	rm -rf ${TMPDIR}

viu: $(VIU)
$(VIU): $(CARGO)
	$(CARGO) install --force viu

zsh-syntax-highlighting: $(ZSH_SYNTAX_HIGHLIGHTING)
$(ZSH_SYNTAX_HIGHLIGHTING):
	mkdir -p $$HOME/bin
	ln -s $(MAKEFILE_DIR)/home/bin/zsh-fast-syntax-highlighting $$HOME/bin
