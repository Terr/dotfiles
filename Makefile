all: youcompleteme

youcompleteme:
	cd home/.vim/bundle/YouCompleteMe/; \
	git submodule update --init --recursive; \
	./install.sh
