all: youcompleteme ctrlp-cmatcher padawan

composer:
	curl -sS https://getcomposer.org/installer | php && \
	mkdir -p /usr/local/bin && \
	mv composer.phar /usr/local/bin/composer

youcompleteme:
	cd home/.vim/bundle/YouCompleteMe && \
	git submodule update --init --recursive && \
	./install.sh

ctrlp-cmatcher:
	cd home/.vim/bundle/ctrlp-cmatcher && \
	./install.sh

padawan: composer
	cd home/.vim/bundle/padawan.vim && \
	git submodule update --init --recursive && \
	cd padawan.php && \
	composer install
