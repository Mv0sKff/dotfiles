#!/bin/sh

# Basic aliases
alias py='python'
alias p='python'
alias v='nvim'
alias nv='nvim'
if command -v bat &> /dev/null; then
  alias cat='bat'
elif command -v batcat &> /dev/null; then
  alias bat='batcat'
  alias cat='batcat'
fi
alias ccat='/usr/bin/cat'

# ls aliases
#alias ls='ls --color=auto'
alias ls='lsd'
alias l='lsd -lha'
alias ll='ls -alF'
alias la='ls -A'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

# grep aliases
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# git aliases
alias gc='git commit -m '
#alias gco='git checkout -b '
alias gsw='git switch'
#alias ga='git add '
alias gaa='git add .'
alias gpush='git push'
alias gpull='git pull'

# misc aliases
alias cd='z'
alias m='make'
alias update='bash ~/.zsh/scripts/update.sh'

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Functions
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

t() {
    local dest="$HOME/.local/share/Trash/files"
    [[ ! -d "$dest" ]] && dest="/tmp"
    local file base new_name timestamp counter

    local opts=()
    while [[ "$1" == -* ]]; do
        opts+=("$1")
        shift
    done

    for file in "$@"; do
        if [[ ! -e "$file" ]]; then
            echo "rm: cannot remove '$file': No such file or directory" >&2
            continue
        fi

        base=$(basename -- "$file")
        timestamp=$(date +%Y%m%d%H%M%S)
        new_name="${base}_${timestamp}"
        counter=1

        while [[ -e "$dest/$new_name" ]]; do
            new_name="${base}_${timestamp}_$counter"
            ((counter++))
        done

        mv "${opts[@]}" -- "$file" "$dest/$new_name"
        echo "Moved '$file' to '$dest/$new_name'"
    done
}

up() {
    local cmd=""

    if [ -f compose.yaml ]; then
        cmd="docker compose up --build"
    elif [ -f compose.yml ]; then
        cmd="docker compose up --build"
    elif [ -f docker-compose.yaml ]; then
        cmd="docker compose up --build"
    elif [ -f docker-compose.yml ]; then
        cmd="docker compose up --build"
    elif [ -f docker-compose.dev.yaml ]; then
        cmd="docker compose -f docker-compose.dev.yaml up --build"
    elif [ -f docker-compose.dev.yml ]; then
        cmd="docker compose -f docker-compose.dev.yml up --build"
    else
        local file=$(ls compose*.yaml compose*.yml docker-compose*.yaml docker-compose*.yml 2>/dev/null | head -1)
        if [ -n "$file" ]; then
            cmd="docker compose -f $file up --build"
        else
            echo "No docker-compose file found"
            return 1
        fi
    fi

    echo "$cmd"
    eval "$cmd"
}

down() {
    local cmd=""

    if [ -f compose.yaml ]; then
        cmd="docker compose down"
    elif [ -f compose.yml ]; then
        cmd="docker compose down"
    elif [ -f docker-compose.yaml ]; then
        cmd="docker compose down"
    elif [ -f docker-compose.yml ]; then
        cmd="docker compose down"
    elif [ -f docker-compose.dev.yaml ]; then
        cmd="docker compose -f docker-compose.dev.yaml down"
    elif [ -f docker-compose.dev.yml ]; then
        cmd="docker compose -f docker-compose.dev.yml down"
    else
        local file=$(ls compose*.yaml compose*.yml docker-compose*.yaml docker-compose*.yml 2>/dev/null | head -1)
        if [ -n "$file" ]; then
            cmd="docker compose -f $file down"
        else
            echo "No docker-compose file found"
            return 1
        fi
    fi

    echo "$cmd"
    eval "$cmd"
}

mc() {
  mkdir $1 &&
  cd $1
}

# copy output of last command to clipboard
cpout() {
  local last_cmd=$(fc -ln -1)
  eval "$last_cmd" 2>&1 | c
  echo "copied."
}

# copy input of last command to clipboard
cpin() {
  fc -ln -1 | sed 's/^[[:space:]]*//' | c
  echo "copied."
}
