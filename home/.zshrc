# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM=$HOME/.oh-my-zsh-custom

# Set name of the theme to load.
ZSH_THEME="nicoulaj-modifaj"

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
plugins=(git mercurial django golang)

source $ZSH/oh-my-zsh.sh

# Limit history
HISTSIZE=5000
SAVEHIST=$HISTSIZE

#
# Enable shared history
# Appends every command to the history file once it is executed
setopt INC_APPEND_HISTORY
# Reloads the history whenever you use it
setopt SHARE_HISTORY
# Don't store commands that are preceded by a space
setopt HIST_IGNORE_SPACE
# Don't store duplicate lines
setopt HIST_IGNORE_ALL_DUPS

# Virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs

if [ -e /etc/bash_completion.d/virtualenvwrapper ]; then
	source /etc/bash_completion.d/virtualenvwrapper
fi

# Aliases
alias -g L="| less"
alias -g G="| grep"
alias git-root='cd $(git rev-parse --show-cdup)'  # cd to root of current git repository
alias l="ls -oa"

## Vagrant aliases
alias vs="vagrant ssh"
alias vu="vagrant up"
alias vh="vagrant halt"
alias vst="vagrant status"
alias vpr="vagrant provision"
alias vrl="vagrant reload"

## Git aliases (on top of those of oh-my-zsh's git plugin)
alias gst="git status --short"
alias gcfix="git commit --fixup"
alias gpfwl="git push --force-with-lease"
alias gmff="git merge --ff-only"

# Python poetry
alias pt="poetry"

## ripgrep aliases
alias rg="rg --pretty"
alias rc="rg --type c --type cpp"
alias rjs="rts"
alias rphp="rg --type php"
alias rpy="rg --type py"
alias rs="rg --type rust"
alias rts="rg --type js --type ts"
alias rw="rg --type web"

## Docker Compose aliases
alias dc="docker-compose"
alias dcu="dc up"
alias dcud="dc up -d"
alias dcs="dc stop"
alias dcrs="dc restart"
alias dce="dc exec"

# mkdir & cd
function mkcd() 
{
    mkdir -p -- "$1" && cd -P -- "$1"
}

# tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

# fzf
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
[ -f ~/.fzf.zsh  ] && source ~/.fzf.zsh

# Apply local settings, such as custom PATHs or aliases. This file is not stored in the dotfiles repository.
if [[ -e $HOME/.zshrc.local ]]; then
	echo "Applying local settings from $HOME/.zshrc.local"
	source $HOME/.zshrc.local
fi
