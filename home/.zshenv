# Apply local environments, such as custom PATHs or aliases. This file is not stored in the dotfiles repository.
if [[ -a $HOME/.zshenv.local ]]; then
	source $HOME/.zshenv.local
fi
