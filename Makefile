all: youcompleteme ctrlp-cmatcher composer padawan

composer:
	curl -sS https://getcomposer.org/installer | php && \
	sudo mkdir -p /usr/local/bin && \
	sudo mv composer.phar /usr/local/bin/composer

youcompleteme:
	cd home/.vim/bundle/YouCompleteMe && \
	git submodule update --init --recursive && \
	./install.sh

ctrlp-cmatcher:
	cd home/.vim/bundle/ctrlp-cmatcher && \
	./install.sh

padawan: composer
	composer global require mkusher/padawan
