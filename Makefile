all: youcompleteme ctrlp-cmatcher

youcompleteme:
	cd home/.vim/bundle/YouCompleteMe/; \
	git submodule update --init --recursive; \
	./install.sh

ctrlp-cmatcher:
	cd home/.vim/bundle/ctrlp-cmatcher/; \
	./install.sh
