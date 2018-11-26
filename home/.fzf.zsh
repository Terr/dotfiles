# Setup fzf
# ---------
if [[ ! "$PATH" == */home/terr/.fzf/bin* ]]; then
  export PATH="$PATH:/home/terr/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/terr/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/terr/.fzf/shell/key-bindings.zsh"

