#!/usr/bin/env bash
# font-switch.sh — change fonts across kitty, sketchybar, wezterm, qutebrowser
# Run without arguments to pick with choose/fzf.
# Run "font-switch.sh <name>" to apply directly.
# Add new fonts by defining a font_<name>() function below.

set -euo pipefail

HOME="${HOME:-/Users/$(whoami)}"
DOTFILES="${DOTFILES:-$HOME/dotfiles}"
KITTY_CONF_PATH="$DOTFILES/kitty/.config/kitty/kitty.conf"
SB_RC="$DOTFILES/sketchybar/.config/sketchybar/sketchybarrc"
WEZTERM_CONF="$HOME/.config/wezterm/wezterm.lua"
QUTE_CONF="$HOME/.qutebrowser/config.py"

# ── Font definitions ───────────────────────────────────────────────
# Each font sets:
#   DISPLAY – human-readable name
#   MONO    – "Mono" variant name (kitty / wezterm / qutebrowser)
#   SB      – base variant name (sketchybar)

font_hack()      { DISPLAY="Hack";            MONO="Hack Nerd Font Mono";           SB="Hack Nerd Font"; }
font_jetbrains() { DISPLAY="JetBrains Mono";  MONO="JetBrainsMono Nerd Font Mono";   SB="JetBrainsMono Nerd Font"; }
font_iosevka()   { DISPLAY="Iosevka";         MONO="Iosevka Nerd Font Mono";         SB="Iosevka Nerd Font"; }
font_fira()      { DISPLAY="Fira Code";       MONO="FiraCode Nerd Font Mono";        SB="FiraCode Nerd Font"; }
font_cascadia()  { DISPLAY="Cascadia Code";   MONO="CaskaydiaCove Nerd Font Mono";   SB="CaskaydiaCove Nerd Font"; }
font_roboto()    { DISPLAY="Roboto Mono";     MONO="RobotoMono Nerd Font Mono";      SB="RobotoMono Nerd Font"; }
font_plex()      { DISPLAY="IBM Plex Mono";   MONO="BlexMono Nerd Font Mono";        SB="BlexMono Nerd Font"; }
font_terminus()  { DISPLAY="Terminus";        MONO="Terminess Nerd Font Mono";       SB="Terminess Nerd Font"; }
font_commit()    { DISPLAY="Commit Mono";     MONO="CommitMono Nerd Font Mono";      SB="CommitMono Nerd Font"; }
font_heavy()     { DISPLAY="Terminess Heavy"; MONO="BlexMono Nerd Font Mono";        SB="BlexMono Nerd Font"; }

# ── Helpers ────────────────────────────────────────────────────────

_write() {
  local file="$1" expr="$2"
  local tmp
  tmp=$(mktemp)
  perl -pe "$expr" "$file" > "$tmp" && cat "$tmp" > "$file" && rm -f "$tmp"
}

list_fonts() {
  declare -F | sed -n 's/^declare -f font_//p' | sort
}

apply_font() {
  local func="$1"
  unset DISPLAY MONO SB
  "font_${func}"

  # Kitty
  [ -n "${MONO:-}" ] && _write "$KITTY_CONF_PATH" 's/^font_family .*/font_family '"${MONO}"'/'

  # Sketchybar (replace name before the :Bold:size, keep size)
  [ -n "${SB:-}" ] && _write "$SB_RC" 's/icon\.font="[^:]*/icon.font="'"${SB}"'/'
  [ -n "${SB:-}" ] && _write "$SB_RC" 's/label\.font="[^:]*/label.font="'"${SB}"'/'

  # WezTerm (optional)
  if [ -n "${MONO:-}" ] && [ -f "$WEZTERM_CONF" ]; then
    _write "$WEZTERM_CONF" 's/config\.font = wezterm\.font\('"'"'[^'"'"']*'"'"'\)/config.font = wezterm.font('"'"''"${MONO}"''"'"')/'
  fi

  # Qutebrowser (optional)
  if [ -n "${MONO:-}" ] && [ -f "$QUTE_CONF" ]; then
    _write "$QUTE_CONF" 's/c\.fonts\.default_family = '"'"'[^'"'"']*'"'"'/c.fonts.default_family = '"'"''"${MONO}"''"'"'/'
  fi

  sketchybar --reload 2>/dev/null || true

  echo "  Font: ${DISPLAY:-$func} (mono=${MONO:-?} bar=${SB:-?})"
}

# ── Main ───────────────────────────────────────────────────────────

if [ $# -gt 0 ]; then
  FONT="$1"
elif command -v choose &>/dev/null; then
  FONT=$(list_fonts | choose)
elif command -v fzf &>/dev/null; then
  FONT=$(list_fonts | fzf --prompt="font> " --height=12)
else
  echo "no picker available (install choose or fzf)"
  echo "usage: font-switch.sh <name>"
  exit 1
fi

if [ -z "${FONT:-}" ]; then
  echo "no font selected"
  exit 1
fi

if declare -f "font_${FONT}" >/dev/null 2>&1; then
  apply_font "$FONT"
else
  echo "unknown font: $FONT"
  echo "available: $(list_fonts | tr '\n' ' ')"
  exit 1
fi
