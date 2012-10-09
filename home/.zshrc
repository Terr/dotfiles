# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set xterm (and xterm-alike) to 256 colors
#export TERM=xterm-256color
export TERM=screen-256color

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="terr"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

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

export EDITOR=vim
export SHELL=zsh

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/home/terr/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/mysql/bin:/var/work/Applications/mongodb-linux-x86_64-2.0.1/bin/:/var/work/Applications/redis-2.4.2/src/

# Virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PYTHONPATH=/var/work/code/
export PROJECT_HOME=/var/work/code/
source /etc/bash_completion.d/virtualenvwrapper

# Aliases
alias tmux="TERM=xterm-256color tmux -2"
alias -g L="| less"
alias -g G="| grep"

# tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator
