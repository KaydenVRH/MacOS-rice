#!/usr/bin/env bash
# theme-switch.sh — apply a theme to kitty, nvim, and sketchybar
# Run without arguments to pick interactively with fzf.
# Run "theme-switch.sh <name>" to apply directly.
# Add new themes by defining a theme_<name>() function below.

set -euo pipefail

HOME="${HOME:-/Users/$(whoami)}"
DOTFILES="${DOTFILES:-$HOME/dotfiles}"
KITTY_CONF_PATH="$DOTFILES/kitty/.config/kitty/kitty.conf"
NVIM_INIT="$DOTFILES/nvim/.config/nvim/init.lua"
SB_RC="$DOTFILES/sketchybar/.config/sketchybar/sketchybarrc"

# ── Theme definitions ──────────────────────────────────────────────
# Each function sets:
#   DISPLAY        – human-readable name
#   KITTY_THEME    – filename of the kitty theme conf to include
#   NVIM_CS        – neovim colorscheme name
#   SB_ACCENT      – sketchybar icon color
#   SB_HIGHLIGHT   – sketchybar label color
#   SB_BG          – sketchybar bracket background (with alpha)
#   WALLPAPER      – path to wallpaper image (leave empty to skip)
#   LV_FG LV_DIM LV_ACCENT LV_MID – lualine colors

theme_mono() {
  DISPLAY="Mono"
  KITTY_THEME="bi.conf"
  NVIM_CS="mono"
  SB_ACCENT="0xffd0d0d0"
  SB_HIGHLIGHT="0xff808080"
  SB_BG="0xCC1a1a1a"
  WALLPAPER="$DOTFILES/wallpapers/monochrome.jpg"
  LV_FG="#e0e0e0"
  LV_DIM="#606060"
  LV_ACCENT="#d0d0d0"
  LV_MID="#a0a0a0"
}

theme_everforest() {
  DISPLAY="Everforest"
  KITTY_THEME="everforest.conf"
  NVIM_CS="everforest"
  SB_ACCENT="0xff83c092"
  SB_HIGHLIGHT="0xff7fbbb3"
  SB_BG="0xCC2d353b"
  WALLPAPER="$DOTFILES/wallpapers/everforest.png"
  LV_FG="#d3c6aa"
  LV_DIM="#859289"
  LV_ACCENT="#83c092"
  LV_MID="#7fbbb3"
}

theme_amber() {
  DISPLAY="Amber"
  KITTY_THEME="amber-amethyst.conf"
  NVIM_CS="amber"
  SB_ACCENT="0xfffbbf24"
  SB_HIGHLIGHT="0xffa855f7"
  SB_BG="0xCC1e1a2e"
  WALLPAPER=""
  LV_FG="#e2e8f0"
  LV_DIM="#8880a0"
  LV_ACCENT="#fbbf24"
  LV_MID="#a855f7"
}

theme_synthwave() {
  DISPLAY="Synthwave"
  KITTY_THEME="synthwave.conf"
  NVIM_CS="mono"
  SB_ACCENT="0xffff2a85"
  SB_HIGHLIGHT="0xff00d4ff"
  SB_BG="0xCC100018"
  WALLPAPER="$DOTFILES/wallpapers/synthwave.jpg"
  LV_FG="#e0d0f0"
  LV_DIM="#9a80aa"
  LV_ACCENT="#ff2a85"
  LV_MID="#00d4ff"
}

theme_cherry_blossom() {
  DISPLAY="Cherry Blossom"
  KITTY_THEME="cherry-blossom.conf"
  NVIM_CS="mono"
  SB_ACCENT="0xfff8a5c2"
  SB_HIGHLIGHT="0xffc3aedb"
  SB_BG="0xCC1c1116"
  WALLPAPER="$DOTFILES/wallpapers/cherryblossom.jpg"
  LV_FG="#f5e6e8"
  LV_DIM="#a88a92"
  LV_ACCENT="#f8a5c2"
  LV_MID="#c3aedb"
}

theme_blue_lagoon() {
  DISPLAY="Blue Lagoon"
  KITTY_THEME="blue-lagoon.conf"
  NVIM_CS="blue-lagoon"
  SB_ACCENT="0xff89cff0"
  SB_HIGHLIGHT="0xff6ba3ff"
  SB_BG="0xCC0e1419"
  WALLPAPER="$DOTFILES/wallpapers/blue-lagoon.jpg"
  LV_FG="#e8f0f8"
  LV_DIM="#8ba0b0"
  LV_ACCENT="#6ba3ff"
  LV_MID="#7ecfd4"
}

theme_amethyst_lagoon() {
  DISPLAY="Amethyst Lagoon"
  KITTY_THEME="amethyst-lagoon.conf"
  NVIM_CS="amethyst-lagoon"
  SB_ACCENT="0xffa78bfa"
  SB_HIGHLIGHT="0xffb8a4f0"
  SB_BG="0xCC120e1a"
  WALLPAPER=""
  LV_FG="#e8e0f0"
  LV_DIM="#8a80a0"
  LV_ACCENT="#a78bfa"
  LV_MID="#b8a4f0"
}

# ── Helpers ────────────────────────────────────────────────────────

# Write perl output to file without changing inode (preserves file watchers)
_replace_inplace() {
  local file="$1" expr="$2"
  local tmp
  tmp=$(mktemp)
  perl -pe "$expr" "$file" > "$tmp" && cat "$tmp" > "$file" && rm -f "$tmp"
}

list_themes() {
  declare -F | sed -n 's/^declare -f theme_//p' | sort
}

apply_theme() {
  local func="$1"

  unset DISPLAY KITTY_THEME NVIM_CS SB_ACCENT SB_HIGHLIGHT SB_BG WALLPAPER LV_FG LV_DIM LV_ACCENT LV_MID

  "theme_${func}"

  # ── Kitty ──────────────────────────────────────────────────────
  if [ -n "${KITTY_THEME:-}" ]; then
    _replace_inplace "$KITTY_CONF_PATH" 's/^include .*/include '"${KITTY_THEME}"'/'
  fi

  # ── Neovim colorscheme ─────────────────────────────────────────
  if [ -n "${NVIM_CS:-}" ]; then
    _replace_inplace "$NVIM_INIT" 's/vim\.cmd\.colorscheme\("[^"]*"\)/vim.cmd.colorscheme("'"${NVIM_CS}"'")/'
  fi

  # ── Neovim lualine ─────────────────────────────────────────────
  if [ -n "${LV_FG:-}" ]; then
    _replace_inplace "$NVIM_INIT" '
      if(/local c = \{/ .. /^\s*\}/){
        s/fg *= *"[^"]*"/fg     = "'"${LV_FG}"'"/;
        s/dim *= *"[^"]*"/dim    = "'"${LV_DIM}"'"/;
        s/accent *= *"[^"]*"/accent = "'"${LV_ACCENT}"'"/;
        s/mid *= *"[^"]*"/mid    = "'"${LV_MID}"'"/;
      }
    '
  fi

  # ── Sketchybar ─────────────────────────────────────────────────
  if [ -n "${SB_ACCENT:-}" ]; then
    _replace_inplace "$SB_RC" 's/^ACCENT=.*/ACCENT='"${SB_ACCENT}"'/'
  fi
  if [ -n "${SB_HIGHLIGHT:-}" ]; then
    _replace_inplace "$SB_RC" 's/^HIGHLIGHT=.*/HIGHLIGHT='"${SB_HIGHLIGHT}"'/'
  fi
  if [ -n "${SB_BG:-}" ]; then
    _replace_inplace "$SB_RC" 's/background\.color=0x[0-9a-fA-F]*/background.color='"${SB_BG}"'/g'
  fi

  # ── Wallpaper ────────────────────────────────────────────────
  if [ -n "${WALLPAPER:-}" ] && [ -f "$WALLPAPER" ]; then
    osascript -e "tell application \"System Events\" to set picture of every desktop to POSIX file \"$WALLPAPER\""
  fi

  # ── Reload ─────────────────────────────────────────────────────
  sketchybar --reload 2>/dev/null || true

  echo ""
  echo "  Applied: ${DISPLAY:-$func}"
  echo "    kitty       → ${KITTY_THEME:-skip}"
  echo "    nvim        → ${NVIM_CS:-skip}"
  echo "    sketchybar  → accent=${SB_ACCENT:-skip} highlight=${SB_HIGHLIGHT:-skip} bg=${SB_BG:-skip}"
  echo "    wallpaper   → ${WALLPAPER:-skip}"
  echo ""
}

# ── Main ───────────────────────────────────────────────────────────

if [ $# -gt 0 ]; then
  THEME="$1"
elif command -v choose &>/dev/null; then
  THEME=$(list_themes | choose)
elif command -v fzf &>/dev/null; then
  THEME=$(list_themes | fzf --prompt="theme> " --height=12)
else
  echo "no picker available (install choose or fzf)"
  echo "usage: theme-switch.sh <name>"
  exit 1
fi

if [ -z "${THEME:-}" ]; then
  echo "no theme selected"
  exit 1
fi

if declare -f "theme_${THEME}" >/dev/null 2>&1; then
  apply_theme "$THEME"
else
  echo "unknown theme: $THEME"
  echo "available: $(list_themes | tr '\n' ' ')"
  exit 1
fi
