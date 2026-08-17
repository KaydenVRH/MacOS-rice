#!/usr/bin/env bash
# opacity.sh — change opacity of kitty and sketchybar
# Run without arguments to pick with choose/fzf.
# Run "opacity.sh <percent>" to apply directly.

set -euo pipefail

HOME="${HOME:-/Users/$(whoami)}"
DOTFILES="${DOTFILES:-$HOME/dotfiles}"
KITTY_CONF_PATH="$DOTFILES/kitty/.config/kitty/kitty.conf"
SB_RC="$DOTFILES/sketchybar/.config/sketchybar/sketchybarrc"

# ── Opacity presets (percent → kitty decimal + sketchybar hex alpha) ─

opacity_100() { OPACITY="1.0"; ALPHA="FF"; DISPLAY="100%"; }
opacity_90()  { OPACITY="0.9"; ALPHA="E6"; DISPLAY="90%"; }
opacity_80()  { OPACITY="0.8"; ALPHA="CC"; DISPLAY="80%"; }
opacity_70()  { OPACITY="0.7"; ALPHA="B3"; DISPLAY="70%"; }
opacity_60()  { OPACITY="0.6"; ALPHA="99"; DISPLAY="60%"; }
opacity_50()  { OPACITY="0.5"; ALPHA="80"; DISPLAY="50%"; }
opacity_40()  { OPACITY="0.4"; ALPHA="66"; DISPLAY="40%"; }

# ── Helpers ────────────────────────────────────────────────────────

_write() {
  local file="$1" expr="$2"
  local tmp
  tmp=$(mktemp)
  perl -pe "$expr" "$file" > "$tmp" && cat "$tmp" > "$file" && rm -f "$tmp"
}

list_levels() {
  declare -F | sed -n 's/^declare -f opacity_//p' | sort -t_ -k2 -n
}

apply_opacity() {
  local func="$1"
  unset OPACITY ALPHA DISPLAY
  "opacity_${func}"

  # Kitty
  [ -n "${OPACITY:-}" ] && _write "$KITTY_CONF_PATH" 's/^background_opacity.*/background_opacity '"${OPACITY}"'/'

  # Sketchybar bracket backgrounds (change alpha channel only)
  [ -n "${ALPHA:-}" ] && _write "$SB_RC" 's/background\.color=0x[0-9a-fA-F]{2}/background.color=0x'"${ALPHA}"'/g'

  sketchybar --reload 2>/dev/null || true

  echo "  Opacity: ${DISPLAY:-$func} (kitty=${OPACITY:-?} bar=0x${ALPHA:-?})"
}

# ── Main ───────────────────────────────────────────────────────────

if [ $# -gt 0 ]; then
  LEVEL="$1"
  LEVEL="${LEVEL%\%}"   # strip trailing %
elif command -v choose &>/dev/null; then
  LEVEL=$(list_levels | choose)
elif command -v fzf &>/dev/null; then
  LEVEL=$(list_levels | fzf --prompt="opacity> " --height=10)
else
  echo "no picker available (install choose or fzf)"
  echo "usage: opacity.sh <percent>"
  exit 1
fi

if [ -z "${LEVEL:-}" ]; then
  echo "no opacity selected"
  exit 1
fi

if declare -f "opacity_${LEVEL}" >/dev/null 2>&1; then
  apply_opacity "$LEVEL"
else
  echo "unknown opacity: $LEVEL"
  echo "available: $(list_levels | tr '\n' ' ')"
  exit 1
fi
