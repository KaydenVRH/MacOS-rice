bash -lc '"'"'SCRIPTS_DIR="$HOME/dotfiles/scripts"; sel="$(find "$SCRIPTS_DIR" -maxdepth 1 -type f -name "*.sh" -print | choose)"; [ -n "$sel" ] && bash "$sel"'\"
