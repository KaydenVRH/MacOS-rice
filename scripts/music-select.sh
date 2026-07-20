file="$(find "$HOME/Music/termusic" -type f | fzf)" || exit
nohup mpv --no-video "$file" </dev/null &>/dev/null &
disown

