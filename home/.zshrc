# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set xterm (and xterm-alike) to 256 colors
#export TERM=xterm-256color
if [[ $TERM == "xterm" ]]; then
	export TERM=xterm-256color
else
	export TERM=screen-256color
fi

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="nicoulaj"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git mercurial django svn)

source $ZSH/oh-my-zsh.sh

# Limit history
HISTSIZE=5000
SAVEHIST=$HISTSIZE

#
# Enable shared history
# Appends every command to the history file once it is executed
setopt inc_append_history
# Reloads the history whenever you use it
setopt share_history

# Virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs

if [ -e /etc/bash_completion.d/virtualenvwrapper ]; then
	source /etc/bash_completion.d/virtualenvwrapper
fi

# Aliases
alias tmux="TERM=xterm-256color tmux -2"  # Start tmux in 256 color mode
alias -g L="| less"
alias -g G="| grep"
alias git-root='cd $(git rev-parse --show-cdup)'  # cd to root of current git repository
alias l="ls -oa"

## Vagrant aliases
alias vs="vagrant ssh"
alias vu="vagrant up"
alias vh="vagrant halt"

## Git aliases (on top of those of oh-my-zsh's git plugin)
alias gst="git status -s"

## ag / Silver Searcher aliases
alias aphp="ag --php"
alias apy="ag --py"

# tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

# fzf
if [[ -e $HOME/.fzf/shell/ ]]; then
    source $HOME/.fzf/shell/completion.zsh
    source $HOME/.fzf/shell/key-bindings.zsh
fi

# Apply local settings, such as custom PATHs or aliases. This file is not stored in the dotfiles repository.
if [[ -e $HOME/.zshrc.local ]]; then
	echo "Applying local settings from $HOME/.zshrc.local"
	source $HOME/.zshrc.local
fi
