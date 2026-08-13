#!/usr/bin/env bash
# bar-style.sh — switch sketchybar styles independently
# Run without arguments to pick with choose/fzf.
# Run "bar-style.sh <name>" to apply directly.
# Add new styles by defining a bar_<name>() function below.

set -euo pipefail

HOME="${HOME:-/Users/$(whoami)}"
DOTFILES="${DOTFILES:-$HOME/dotfiles}"
SB_RC="$DOTFILES/sketchybar/.config/sketchybar/sketchybarrc"

# ── Style definitions ──────────────────────────────────────────────
# Each style sets:
#   DISPLAY        – human-readable name
#   SB_ACCENT      – icon color
#   SB_HIGHLIGHT   – label color
#   SB_BG          – bracket background (with alpha)
#   SB_BAR_HEIGHT  – bar height
#   SB_BAR_CORNER  – bar corner radius
#   SB_BAR_BLUR    – bar blur radius
#   SB_GROUP_HEIGHT– bracket height
#   SB_GROUP_CORNER– bracket corner radius
#   SB_FONT_ICON   – icon font size
#   SB_FONT_LABEL  – label font size

bar_default() {
  DISPLAY="Default"
  SB_ACCENT="0xff83c092"
  SB_HIGHLIGHT="0xff7fbbb3"
  SB_BG="0xCC2d353b"
  SB_BAR_HEIGHT="34"
  SB_BAR_CORNER="8"
  SB_BAR_BLUR="24"
  SB_GROUP_HEIGHT="28"
  SB_GROUP_CORNER="6"
  SB_FONT_ICON="17.0"
  SB_FONT_LABEL="14.0"
}

bar_dwm() {
  DISPLAY="DWM"
  SB_ACCENT="0xffcccccc"
  SB_HIGHLIGHT="0xff999999"
  SB_BG="0xFF222222"
  SB_BAR_HEIGHT="24"
  SB_BAR_CORNER="0"
  SB_BAR_BLUR="0"
  SB_GROUP_HEIGHT="22"
  SB_GROUP_CORNER="0"
  SB_FONT_ICON="14.0"
  SB_FONT_LABEL="12.0"
}

bar_retro() {
  DISPLAY="Retro"
  SB_ACCENT="0xffFFFF00"
  SB_HIGHLIGHT="0xff00FFFF"
  SB_BG="0xCC0000AA"
  SB_BAR_HEIGHT="34"
  SB_BAR_CORNER="8"
  SB_BAR_BLUR="24"
  SB_GROUP_HEIGHT="28"
  SB_GROUP_CORNER="6"
  SB_FONT_ICON="17.0"
  SB_FONT_LABEL="14.0"
}

bar_mono() {
  DISPLAY="Mono"
  SB_ACCENT="0xffd0d0d0"
  SB_HIGHLIGHT="0xff808080"
  SB_BG="0xCC1a1a1a"
  SB_BAR_HEIGHT="34"
  SB_BAR_CORNER="8"
  SB_BAR_BLUR="24"
  SB_GROUP_HEIGHT="28"
  SB_GROUP_CORNER="6"
  SB_FONT_ICON="17.0"
  SB_FONT_LABEL="14.0"
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
  unset DISPLAY SB_ACCENT SB_HIGHLIGHT SB_BG SB_BAR_HEIGHT SB_BAR_CORNER SB_BAR_BLUR \
        SB_GROUP_HEIGHT SB_GROUP_CORNER SB_FONT_ICON SB_FONT_LABEL
  "bar_${func}"

  # Colors
  [ -n "${SB_ACCENT:-}" ]    && _write "$SB_RC" 's/^ACCENT=.*/ACCENT='"${SB_ACCENT}"'/'
  [ -n "${SB_HIGHLIGHT:-}" ] && _write "$SB_RC" 's/^HIGHLIGHT=.*/HIGHLIGHT='"${SB_HIGHLIGHT}"'/'
  [ -n "${SB_BG:-}" ]        && _write "$SB_RC" 's/background\.color=0x[0-9a-fA-F]*/background.color='"${SB_BG}"'/g'

  # Bar geometry
  [ -n "${SB_BAR_HEIGHT:-}" ] && _write "$SB_RC" 's/position=top height=[0-9]*/position=top height='"${SB_BAR_HEIGHT}"'/'
  [ -n "${SB_BAR_CORNER:-}" ] && [ -n "${SB_BAR_BLUR:-}" ] && \
    _write "$SB_RC" 's/corner_radius=[0-9]* blur_radius=[0-9]*/corner_radius='"${SB_BAR_CORNER}"' blur_radius='"${SB_BAR_BLUR}"'/'

  # Group / bracket geometry
  [ -n "${SB_GROUP_CORNER:-}" ] && _write "$SB_RC" 's/background\.corner_radius=[0-9]*/background.corner_radius='"${SB_GROUP_CORNER}"'/g'
  [ -n "${SB_GROUP_HEIGHT:-}" ] && _write "$SB_RC" 's/background\.height=[0-9]*/background.height='"${SB_GROUP_HEIGHT}"'/g'

  # Fonts
  [ -n "${SB_FONT_ICON:-}" ]  && _write "$SB_RC" 's/icon\.font="[^"]*"/icon.font="Hack Nerd Font:Bold:'"${SB_FONT_ICON}"'"/'
  [ -n "${SB_FONT_LABEL:-}" ] && _write "$SB_RC" 's/label\.font="[^"]*"/label.font="Hack Nerd Font:Bold:'"${SB_FONT_LABEL}"'"/'

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
