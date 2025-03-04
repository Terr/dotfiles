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
plugins=(git golang)

source $ZSH/oh-my-zsh.sh

# Limit history
HISTSIZE=5000
SAVEHIST=$HISTSIZE

#
# Enable shared history
# Appends every command to the history file once it is executed
setopt INC_APPEND_HISTORY
# Do not reload the command history whenever you use it
setopt NO_SHARE_HISTORY
# Don't store commands that are preceded by a space
setopt HIST_IGNORE_SPACE
# Don't store duplicate lines
setopt HIST_IGNORE_ALL_DUPS

# Aliases
alias -g L="|less"
alias -g G="|grep"
alias -g T="|tail -f -n $(tput lines)"
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
alias gb="git branch -vv"
alias gst="git status --short"
alias gcfix="git commit --fixup"
alias gpfwl="git push --force-with-lease"
alias gmff="git merge --ff-only"
alias gs="git stash"
alias gsp="git stash pop"
alias gsa="git stash apply"
alias gsl="git stash list"

## Python poetry
alias pt="poetry"
### Poetry 2.0 doesn't come with a "shell" command by default anymore
alias pts='$(poetry env activate)'

## ripgrep aliases
alias rg="rg --pretty"
alias rc="rg --type c --type cpp"
alias rjs="rts"
alias rphp="rg --type php"
alias rpy="rg --type py"
alias rs="rg --type rust"
alias rts="rg --type js --type ts"
alias rw="rg --type web"

## Docker aliases
alias drun='docker run --rm -ti'
alias di="docker images"
alias dps="docker ps"
alias dexec="docker exec -ti"
alias dins="docker inspect"

## Docker Compose aliases
alias dc="docker-compose"
alias dcu="dc up"
alias dcud="dc up -d"
alias dcs="dc stop"
alias dcrs="dc restart"
alias dce="dc exec"

## 7zip
alias 7x="7z x"
alias 7l="7z l"

## tar
alias ztar="tar --zstd"

## Semgrep
alias sg="semgrep --disable-version-check"

## Terraform
alias tf="terraform"
alias tfw="terraform workspace show"
alias tfws="terraform workspace select"

## Neovim
alias nv="nvim"

## Minikube
alias mk="minikube"

## Kubectl
alias kc="kubectl"

## Send a commonly used TERM when ssh'ing and using an uncommon TERM
[[ "$TERM" == "tmux-256color" || "$TERM" == "alacritty" ]] && alias ssh="TERM=screen ssh"

# Inspect a Docker Compose container
function dcins() 
{
	docker inspect $(dc ps -q "$1")
}

# mkdir & cd
function mkcd() 
{
	mkdir -p -- "$1" && cd -P -- "$1"
}

function open() {
	if [ "$(uname)" = "Darwin" ]; then
		/usr/bin/open $@
	elif command -v handlr &>/dev/null; then
		handlr open $@
	else
		xdg-open 1>~/.local/open.log 2>&1 $@ &
	fi
}

# ls colors
[ -f "$HOME"/bin/LS_COLORS ] && which dircolors >/dev/null && eval $(dircolors -b "$HOME"/bin/LS_COLORS)

# Command line syntax highlighting
[ -d "$HOME/bin/zsh-fast-syntax-highlighting" ] && source "$HOME/bin/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"

# tmuxinator
[ -s "$HOME/.tmuxinator/scripts/tmuxinator" ] && source "$HOME/.tmuxinator/scripts/tmuxinator"

# fzf
[ -f ~/.fzf.zsh  ] && source ~/.fzf.zsh

# fasd
[ -f  "$HOME"/bin/fasd ] && eval "$($HOME/bin/fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install)"

# Apply local settings, such as custom aliases. This file is not stored in the dotfiles repository.
if [[ -e $HOME/.zshrc.local ]]; then
    echo "Applying local settings from $HOME/.zshrc.local"
    source $HOME/.zshrc.local
fi
