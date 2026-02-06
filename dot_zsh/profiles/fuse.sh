# Fuse Profile
#echo "[fuse profile]"

alias n='nautilus . &'

alias rcssserver3d='distrobox enter ubuntu -- bash -c "/usr/bin/rcssserver3d"'
alias roboviz='~/uopt/RoboViz/bin/roboviz.sh'
alias robocup='roboviz &;rcssserver3d; fg %1'
alias conda='distrobox enter fedora-anaconda'
alias code='flatpak run com.visualstudio.code'
#alias mysql-workbench='distrobox enter archlinux-latest -- mysql-workbench'
#alias oracle-sqldeveloper='distrobox enter archlinux-latest -- oracle-sqldeveloper'
#alias oracle-datamodeler='distrobox enter archlinux-latest -- oracle-datamodeler'
#alias rcssserver3d='distrobox enter ubuntu -- rcssserver3d'
#alias c='flatpak run com.visualstudio.code .'
alias c='wl-copy'

# Docker rootless
export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock