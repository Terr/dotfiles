# Setup fzf
# ---------
if [[ ! "$PATH" == */home/terr/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/terr/.fzf/bin"
fi

source <(fzf --zsh)
