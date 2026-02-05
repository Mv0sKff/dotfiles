# Shift + Arrow Key selection
bindkey -e

function zle-line-init {
    marking=0
}
zle -N zle-line-init

function select-char-right {
    if (( $marking != 1 ))
    then
        marking=1
        zle set-mark-command
    fi
    zle .forward-char
}
zle -N select-char-right

function select-char-left {
    if (( $marking != 1 ))
    then
        marking=1
        zle set-mark-command
    fi
    zle .backward-char
}
zle -N select-char-left

function select-word-right {
    if (( $marking != 1 ))
    then
        marking=1
        zle set-mark-command
    fi
    zle .forward-word
}
zle -N select-word-right

function select-word-left {
    if (( $marking != 1 ))
    then
        marking=1
        zle set-mark-command
    fi
    zle .backward-word
}
zle -N select-word-left

function forward-char {
    if (( $marking == 1 ))
    then
        marking=0
        NUMERIC=-1 zle set-mark-command
    fi
    zle .forward-char
}
zle -N forward-char

function backward-char {
    if (( $marking == 1 ))
    then
        marking=0
        NUMERIC=-1 zle set-mark-command
    fi
    zle .backward-char
}
zle -N backward-char

function forward-word {
    if (( $marking == 1 ))
    then
        marking=0
        NUMERIC=-1 zle set-mark-command
    fi
    zle .forward-word
}
zle -N forward-word

function backward-word {
    if (( $marking == 1 ))
    then
        marking=0
        NUMERIC=-1 zle set-mark-command
    fi
    zle .backward-word
}
zle -N backward-word

function delete-char {
    if (( $marking == 1 ))
    then
        zle kill-region
        marking=0
    else
        zle .delete-char
    fi
}
zle -N delete-char

function copy-region {
    if (( $marking == 1 ))
    then
        zle copy-region-as-kill
        echo -n $CUTBUFFER | c
        marking=0
        NUMERIC=-1 zle set-mark-command
    fi
}
zle -N copy-region

# Shift+Arrow key bindings for different terminals
bindkey '^[[1;2C' select-char-right  # Shift+Right
bindkey '^[[1;2D' select-char-left   # Shift+Left

# Ctrl+Shift+Arrow key bindings (word selection)
bindkey '^[[1;6C' select-word-right  # Ctrl+Shift+Right
bindkey '^[[1;6D' select-word-left   # Ctrl+Shift+Left

# Ctrl+Arrow key bindings (word movement, clears selection)
bindkey '^[[1;5C' forward-word       # Ctrl+Right
bindkey '^[[1;5D' backward-word      # Ctrl+Left

# Copy selected text
bindkey '^Y' copy-region                      # Ctrl+Y
bindkey '^[[67;6u' copy-region                # Ctrl+Shift+C (most terminals)
#bindkey '^[[67;5u' copy-region                # Ctrl+Shift+C (fallback)
#bindkey '^[^C' copy-region                    # Ctrl+Shift+C (alternate)
#bindkey '\e[99;5u' copy-region                # Ctrl+Shift+C (idk)
