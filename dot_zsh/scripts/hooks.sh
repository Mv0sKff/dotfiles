#!/bin/sh

if [ -n "$ZSH_VERSION" ]; then
    SHELL_TYPE="zsh"
elif [ -n "$BASH_VERSION" ]; then
    SHELL_TYPE="bash"
else
    return
fi

eval "$(starship init $SHELL_TYPE)"
eval "$(zoxide init $SHELL_TYPE)"
eval "$(direnv hook $SHELL_TYPE)"

[[ -f /home/linuxbrew/.linuxbrew/bin/brew ]] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

eval "$(uv generate-shell-completion $SHELL_TYPE)"
eval "$(uvx --generate-shell-completion $SHELL_TYPE)"

if command -v asdf &> /dev/null; then
    . <(asdf completion $SHELL_TYPE)
fi

# kubernetes
#if command -v kubectl &> /dev/null; then
#    source <(kubectl completion $SHELL_TYPE)
#    if [ "$SHELL_TYPE" = "bash" ]; then
#        complete -o default -F __start_kubectl k
#    elif [ "$SHELL_TYPE" = "zsh" ]; then
#        compdef __start_kubectl k
#    fi
#fi

[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"

# rust
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

# nvm
if [[ -f "$HOME/.nvm/nvm.sh" ]]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    if [ -s "$NVM_DIR/bash_completion" ]; then
        if [ "$SHELL_TYPE" = "zsh" ]; then
            autoload -U +X bashcompinit && bashcompinit
        fi
        \. "$NVM_DIR/bash_completion"
    fi
fi

# javascript
[[ -f "$HOME/.yarn/bin/yarn" ]] && export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# python
[[ -d "$HOME/.pyenv" ]] && export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - $SHELL_TYPE)"

if command -v pyenv >/dev/null 2>&1; then
    eval "$(pyenv virtualenv-init -)"
    . "$HOME/.zsh/autocomplete/hatch-complete.$SHELL_TYPE"
fi
