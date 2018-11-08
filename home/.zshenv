export EDITOR=vim
export SHELL=zsh

# Settings for less: quit if only 1 page of text, output color control
# characters in raw format and do not clear screen when starting/quitting less
export LESS=-FRX

# Tell ack to display colored, paged results
export ACK_PAGER_COLOR="${PAGER:-less}"

# Colors for ls
export LSCOLORS=ExGxcxdxCxegedabagacad

# FZF
export FZF_COMPLETION_TRIGGER='~~'

# ripgrep
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

# Customize to your needs...
export PATH=$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$HOME/.fzf:$HOME/.fzf/bin

# Apply local environments, such as custom PATHs or aliases. This file is not stored in the dotfiles repository.
if [[ -e $HOME/.zshenv.local ]]; then
	source $HOME/.zshenv.local
fi
