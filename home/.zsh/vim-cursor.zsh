# Set cursor shape depending on the vim mode
# Mostly taken from: https://gist.github.com/LukeSmithxyz/e62f26e55ea8b0ed41a65912fbebbe52
#
# Set cursor style (DECSCUSR), VT520.
# 0:  blinking block.
# 1:  blinking block (default).
# 2:  steady block.
# 3:  blinking underline.
# 4:  steady underline.
# 5:  blinking bar, xterm.
# 6:  steady bar, xterm.

function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] ||
        [[ $1 = 'block' ]]; then
            echo -ne '\e[1 q'
    elif [[ ${KEYMAP} == main ]] || 
        [[ ${KEYMAP} == viins ]] ||
        [[ ${KEYMAP} = '' ]] ||
        [[ $1 = 'beam' ]]; then
            echo -ne '\e[5 q'
    fi
}
zle -N zle-keymap-select

# Returns cursor back to bar shape
_fix_cursor() {
   echo -ne '\e[5 q'
}

# Use bar shape cursor for each new prompt
precmd_functions+=(_fix_cursor)
