# dot_emacs.d

# WSL
  .bash_aliases
----
    alias src='cd /home/gnakagami/win_home/src'
----
  .bashrc
----
# xserver
(
    command_path="/mnt/c/Program Files/VcXsrv/vcxsrv.exe"
    command_name=$(basename "$command_path")

    if ! tasklist.exe 2> /dev/null | fgrep -q "$command_name"; then
        "$command_path" :0 -multiwindow -clipboard -noprimary -wgl > /dev/null 2>&1 &
        sleep 3
    fi
)

if [ "$INSIDE_EMACS" ]; then
    TERM=eterm-color
fi

umask 022
export DISPLAY=localhost:0.0

# for flicker
xset -r 49

# export NO_AT_BRIDGE=1
export LIBGL_ALWAYS_INDIRECT=1
# export GIGACAGE_ENABLED=no

cd $HOME
-----