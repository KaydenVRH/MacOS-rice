#!/usr/bin/env bash
# script-picker.sh — fzf over ~/dotfiles/scripts and run the chosen one.
#
# Bound to `prefix + s` in tmux (inside a popup) and to `ctrl+b> s` in kitty
# (inside an overlay), so the same list is one key away in either multiplexer.
#
#   script-picker.sh [directory]

set -uo pipefail

DIR="${1:-$HOME/dotfiles/scripts}"

command -v fzf >/dev/null 2>&1 || { echo "script-picker: fzf is not installed"; exit 1; }

script=$(find "$DIR" -maxdepth 1 -type f ! -name ".*" ! -name "*.md" | sort \
  | fzf --prompt="script> " --height=100% --reverse --no-sort) || exit 0

[ -n "${script:-}" ] || exit 0

bash "$script"

# Keep the output readable: the popup closes as soon as this returns.
echo
printf 'Press enter to close'
read -r _
