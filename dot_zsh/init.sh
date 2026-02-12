#!/bin/sh

# Set clipboard manager (very important)
if command -v clip.exe &> /dev/null; then
    alias c='clip.exe'
elif command -v wl-copy &> /dev/null; then
    alias c='wl-copy'
elif command -v xclip &> /dev/null; then
    alias c='xclip -selection clipboard'
else
    echo "No clipboard manager found"
    alias c='echo "No clipboard manager found"'
fi

SHELL_DIR="$HOME/.zsh"

source "$SHELL_DIR/scripts/paths.sh"

HOSTNAME=$(hostname)

case "$HOSTNAME" in
    *N01*)
        . "$SHELL_DIR/profiles/corp.sh"
        ;;
    *fuse*)
        . "$SHELL_DIR/profiles/fuse.sh"
        ;;
    *localpc*)
        . "$SHELL_DIR/profiles/localpc.sh"
        ;;
esac

source "$SHELL_DIR/aliases.sh"
source "$SHELL_DIR/scripts/hooks.sh"

if [ -n "$ZSH_VERSION" ]; then
    source "$SHELL_DIR/scripts/shift-select.sh"
    source "$SHELL_DIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    #source "$SHELL_DIR/plugins/zsh-history-substring-search.zsh"
    source "$SHELL_DIR/plugins/zsh-fzf-history-search/zsh-fzf-history-search.zsh"
    source "$SHELL_DIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi