export EDITOR=vim
export SHELL=zsh

# Settings for less: quit if only 1 page of text, output color control
# characters in raw format and do not clear screen when starting/quitting less
export LESS=-FRX

# Colors for ls
export LSCOLORS=ExGxcxdxCxegedabagacad

# FZF
export FZF_COMPLETION_TRIGGER='~~'

# ripgrep
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

# Apply local environments, such as custom PATHs or aliases. This file is not stored in the dotfiles repository.
if [[ -e $HOME/.zshenv.local ]]; then
	source $HOME/.zshenv.local
fi
