# ROS-Ubuntu Profile
echo "[ros-ubuntu profile]"

unset PYENV_ROOT
unset PYENV_VERSION
unset PYENV_DIR
unset PYENV_VIRTUALENV_INIT

unset -f pyenv
unset -f _pyenv_virtualenv_hook

export PATH="/home/me/.opencode/bin:/usr/share/Modules/bin:/usr/lib64/ccache:/usr/local/bin:/usr/bin:/home/me/.local/bin:/usr/local/sbin:/usr/sbin:/sbin:/bin"

alias python='python3'
alias p='python3'
