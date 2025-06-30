# Useful documentation for ZLE (ZSH Line Editor):
# - https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html
# - https://thevaluable.dev/zsh-line-editor-configuration-mouseless/
# - https://zsh.sourceforge.io/Guide/zshguide04.html

ZSH_CACHE_DIR=$HOME/.cache/zsh
if [[ ! -d "$ZSH_CACHE_DIR" ]]; then mkdir "$ZSH_CACHE_DIR"; fi

# Set the time ZSH waits for multi-key inputs. Most notably, this influences the
# delay when switching between command and insert modes.
#
# Alternatively, if this makes using any multi-key inputs difficult to use, it's
# also possible to unbind all escape-prefixed commands, but this would disable
# e.g. ALT/ESC-. to insert the last argument of the previous command
# bindkey -rpM viins '^['
# bindkey -rpM vicmd '^['
#
# (value is in hundredths of a second)
KEYTIMEOUT=1

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=$HISTSIZE

# Appends every command to the history file once it is executed
setopt INC_APPEND_HISTORY
# Do not reload the command history whenever you use it
setopt NO_SHARE_HISTORY
# Don't store commands that are preceded by a space
setopt HIST_IGNORE_SPACE
# Don't store duplicate lines
setopt HIST_IGNORE_ALL_DUPS
# Push directory names onto the pushd/popd stack, but ignore duplicates
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS

# Enable vim mode for ZLE
bindkey -v

# Set cursor shape depending on the vim mode
source $HOME/.zsh/vim-cursor.zsh

# Comprehensive complation settings
source $HOME/.zsh/completion.zsh

# Line navigation
## Ctrl-A & Ctrl-E
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey -M vicmd '^A' beginning-of-line
bindkey -M vicmd '^E' end-of-line
## Home & End keys
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line
bindkey -M vicmd '^[[1~' beginning-of-line
bindkey -M vicmd '^[[4~' end-of-line

# Starting from the cursor, remove the rest of the line
bindkey '^K' kill-line

# Delete previous word using alt-backspace
bindkey "^[^?" backward-kill-word

# Stashes the current line until after the next command
bindkey "^[q" push-line
bindkey -M vicmd "^[q" push-line

# Find matching history entries based on the current, partially typed command
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
## Different command characters for different terminals
## (use C-V + key in vim to see what the current terminal emits)
bindkey "^[OA" history-beginning-search-backward-end
bindkey "^[OB" history-beginning-search-forward-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

# Have backspace key behave as expected, which is different from classic vi
# behaviour
bindkey "" backward-delete-char
bindkey -M vicmd "" backward-delete-char

# Delete characters when pressing the Delete key(!)
bindkey "[3~" delete-char
bindkey -M vicmd "[3~" delete-char

# Insert arguments from previous commands with ALT- or ESC-. and ,
bindkey "^[." insert-last-word
bindkey -M vicmd "^[." insert-last-word
autoload -U copy-earlier-word
zle -N copy-earlier-word
bindkey "^[," copy-earlier-word

# Automatically escape special characters in URLs
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# Aliases

## Shortcuts for piping output to common tools
alias -g L="|less"
alias -g G="|grep"
alias -g T="|tail -f -n $(tput lines)"

## cd aliases
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

## ls aliases
alias l="ls -oa"
alias ll="ls -oalh"
alias ls="ls --color=auto"

## Vagrant aliases
alias vh="vagrant halt"
alias vpr="vagrant provision"
alias vrl="vagrant reload"
alias vs="vagrant ssh"
alias vst="vagrant status"
alias vu="vagrant up"

## Git aliases (on top of those of oh-my-zsh's git plugin)
alias g="git"
alias ga="git add"
alias gb="git branch -vv"
alias gbr="git branch --remote -vv"
alias gc!="git commit --verbose --amend"
alias gc="git commit"
alias gcb="git checkout -b"
alias gcfix="git commit --fixup"
alias gcl="git clone"
alias gcn!="git commit --verbose --amend --no-edit"
alias gco="git checkout"
alias gd="git diff"
alias gdca="git diff --cached"
alias gf="git fetch"
alias gfa="git fetch --all"
alias gcd='cd $(git rev-parse --show-cdup)'  # cd to root of current git repository
alias glg="git log --stat"
alias gmff="git merge --ff-only"
alias gp="git push"
alias gpfwl="git push --force-with-lease"
alias grb="git rebase"
alias grba="git rebase --abort"
alias grbc="git rebase --continue"
alias grbi="git rebase --interactive"
alias gs="git stash"
alias gsa="git stash apply"
alias gsl="git stash list"
alias gsp="git stash pop"
alias gst="git status --short"

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
alias dexec="docker exec -ti"
alias di="docker images"
alias dins="docker inspect"
alias dps="docker ps"
alias drun='docker run --rm -ti'

## Docker Compose aliases
alias dc="docker-compose"
alias dce="dc exec"
alias dcrs="dc restart"
alias dcs="dc stop"
alias dcu="dc up"
alias dcud="dc up -d"

## 7zip
alias 7l="7z l"
alias 7x="7z x"

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

# Extra git functions
source $HOME/.zsh/git.zsh

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

# Theme
autoload -U colors && colors
source $HOME/.zsh/spectrum.zsh
source ~/.zsh/themes/nicoulaj-modifaj.zsh-theme

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
