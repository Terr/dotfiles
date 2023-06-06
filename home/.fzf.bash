# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/terr/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/Users/terr/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/terr/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/Users/terr/.fzf/shell/key-bindings.bash"
