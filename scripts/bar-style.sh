#!/usr/bin/env bash
# bar-style.sh — switch sketchybar styles independently
# Run without arguments to pick with choose/fzf.
# Run "bar-style.sh <name>" to apply directly.

set -euo pipefail

HOME="${HOME:-/Users/$(whoami)}"
DOTFILES="${DOTFILES:-$HOME/dotfiles}"
SB_RC="$DOTFILES/sketchybar/.config/sketchybar/sketchybarrc"

# ── Style definitions ──────────────────────────────────────────────

bar_default() {
  DISPLAY="Default"
  SB_ACCENT="0xff83c092"
  SB_HIGHLIGHT="0xff7fbbb3"
  SB_BG="0xCC2d353b"
}

bar_retro() {
  DISPLAY="Retro"
  SB_ACCENT="0xffFFFF00"
  SB_HIGHLIGHT="0xff00FFFF"
  SB_BG="0xCC0000AA"
}

bar_mono() {
  DISPLAY="Mono"
  SB_ACCENT="0xffd0d0d0"
  SB_HIGHLIGHT="0xff808080"
  SB_BG="0xCC1a1a1a"
}

# ── Helpers ────────────────────────────────────────────────────────

_write() {
  local file="$1" expr="$2"
  local tmp
  tmp=$(mktemp)
  perl -pe "$expr" "$file" > "$tmp" && cat "$tmp" > "$file" && rm -f "$tmp"
}

list_styles() {
  declare -F | sed -n 's/^declare -f bar_//p' | sort
}

apply_style() {
  local func="$1"
  unset DISPLAY SB_ACCENT SB_HIGHLIGHT SB_BG
  "bar_${func}"

  if [ -n "${SB_ACCENT:-}" ]; then
    _write "$SB_RC" 's/^ACCENT=.*/ACCENT='"${SB_ACCENT}"'/'
  fi
  if [ -n "${SB_HIGHLIGHT:-}" ]; then
    _write "$SB_RC" 's/^HIGHLIGHT=.*/HIGHLIGHT='"${SB_HIGHLIGHT}"'/'
  fi
  if [ -n "${SB_BG:-}" ]; then
    _write "$SB_RC" 's/background\.color=0x[0-9a-fA-F]*/background.color='"${SB_BG}"'/g'
  fi

  sketchybar --reload 2>/dev/null || true

  echo "  Bar style: ${DISPLAY:-$func}"
}

# ── Main ───────────────────────────────────────────────────────────

if [ $# -gt 0 ]; then
  STYLE="$1"
elif command -v choose &>/dev/null; then
  STYLE=$(list_styles | choose)
elif command -v fzf &>/dev/null; then
  STYLE=$(list_styles | fzf --prompt="bar> " --height=10)
else
  echo "no picker available (install choose or fzf)"
  echo "usage: bar-style.sh <name>"
  exit 1
fi

if [ -z "${STYLE:-}" ]; then
  echo "no style selected"
  exit 1
fi

if declare -f "bar_${STYLE}" >/dev/null 2>&1; then
  apply_style "$STYLE"
else
  echo "unknown style: $STYLE"
  echo "available: $(list_styles | tr '\n' ' ')"
  exit 1
fi
