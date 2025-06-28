# Useful documentation:
# - https://github.com/zsh-users/zsh-completions/blob/master/zsh-completions-howto.org
#
# Code taken from https://github.com/ohmyzsh/ohmyzsh/ was licensed under:
#
# MIT License
# 
# Copyright (c) 2009-2022 Robby Russell and contributors (https://github.com/ohmyzsh/ohmyzsh/contributors)
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
# Most code taken from: https://github.com/ohmyzsh/ohmyzsh/blob/042605ee6b2afeb21e380d05b22d5072f0eeff44/lib/completion.zsh
#
# fixme - the load process here seems a bit bizarre
zmodload -i zsh/complist

WORDCHARS=''

unsetopt menu_complete   # do not autoselect the first completion entry
unsetopt flowcontrol

# Show a menu when are multiple completion options
setopt AUTO_MENU
# Move cursor to end after completing a word
setopt ALWAYS_TO_END
# When initiating completion, don't move the cursor to the end of the word and
# try to complete from "both ends" of the word
setopt COMPLETE_IN_WORD

bindkey -M menuselect '^o' accept-and-infer-next-history
zstyle ':completion:*:*:*:*:*' menu select

# Case insensitive (all), partial-word and substring completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|=*' 'l:|=* r:|=*'

# Complete . and .. special directories
zstyle ':completion:*' special-dirs true

zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

zstyle ':completion:*:*:*:*:processes' command "ps -u $USERNAME -o pid,user,comm -w -w"

# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path $ZSH_CACHE_DIR

if [[ ${COMPLETION_WAITING_DOTS:-false} != false ]]; then
  expand-or-complete-with-dots() {
    # use $COMPLETION_WAITING_DOTS either as toggle or as the sequence to show
    [[ $COMPLETION_WAITING_DOTS = true ]] && COMPLETION_WAITING_DOTS="%F{red}…%f"
    # turn off line wrapping and print prompt-expanded "dot" sequence
    printf '\e[?7l%s\e[?7h' "${(%)COMPLETION_WAITING_DOTS}"
    zle expand-or-complete
    zle redisplay
  }
  zle -N expand-or-complete-with-dots
  # Set the function as the default tab completion widget
  bindkey -M emacs "^I" expand-or-complete-with-dots
  bindkey -M viins "^I" expand-or-complete-with-dots
  bindkey -M vicmd "^I" expand-or-complete-with-dots
fi

# Initialize ZSH's advanced completion system
# Be sure that this is called only once to minimize startup time
autoload -Uz compinit && compinit

# Automatically load bash completion functions
autoload -U +X bashcompinit && bashcompinit

