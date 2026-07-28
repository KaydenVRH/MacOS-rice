#!/usr/bin/env bash

CACHE="/tmp/sketchybar_brew_count"

BREW="$(command -v brew 2>/dev/null || echo /opt/homebrew/bin/brew)"

if [ ! -x "$BREW" ]; then
  sketchybar --set "$NAME" label.drawing=off
  exit 0
fi

("$BREW" outdated --quiet 2>/dev/null | wc -l | tr -d ' ' > "$CACHE" 2>/dev/null) &

COUNT=0
[ -f "$CACHE" ] && COUNT=$(cat "$CACHE" 2>/dev/null)

if [ -n "$COUNT" ] && [ "$COUNT" -gt 0 ] 2>/dev/null; then
  sketchybar --set "$NAME" label.drawing=on label="$COUNT"
else
  sketchybar --set "$NAME" label.drawing=off
fi
