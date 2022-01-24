export PATH="$PATH:/home/mf/.local/bin"

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && startx
