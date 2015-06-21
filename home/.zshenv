# Apply local environments, such as custom PATHs or aliases. This file is not stored in the dotfiles repository.
if [[ -a $HOME/.zshenv.local ]]; then
	echo "Applying local envs from $HOME/.zshenv.local"
	source $HOME/.zshenv.local
fi
