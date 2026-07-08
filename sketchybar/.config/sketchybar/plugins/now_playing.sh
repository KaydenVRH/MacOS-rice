#!/usr/bin/env bash

CACHE="$CONFIG_DIR/plugins/.now_playing_cache"
LOG="/tmp/sketchybar_now_playing.log"

TRACK=""
HAS_ARTWORK=true

# Spotify
TRACK=$(osascript -e 'tell application "Spotify" to if player state is playing then return name of current track & " · " & artist of current track' 2>/dev/null)

# Apple Music
if [ -z "$TRACK" ]; then
  TRACK=$(osascript -e 'tell application "Music" to if player state is playing then return name of current track & " · " & artist of current track' 2>/dev/null)
fi

# nowplaying-cli (browser, other media apps)
if [ -z "$TRACK" ] && command -v nowplaying-cli &>/dev/null; then
  TITLE=$(nowplaying-cli get title 2>/dev/null)
  ARTIST=$(nowplaying-cli get artist 2>/dev/null)
  if [ -n "$TITLE" ] && [ "$TITLE" != "(null)" ] && [ "$TITLE" != "null" ]; then
    if [ -n "$ARTIST" ] && [ "$ARTIST" != "(null)" ] && [ "$ARTIST" != "null" ]; then
      TRACK="$TITLE · $ARTIST"
    else
      TRACK="$TITLE"
    fi
  fi
fi

# termusic-server
if [ -z "$TRACK" ] && pgrep -x termusic-server &>/dev/null; then
  FILE=$(lsof -c termusic-server 2>/dev/null | grep -E '\.(mp3|flac|m4a|wav|ogg|aac|opus)$' | sort -k2 -rn | head -1 | grep -oE '/.*\.(mp3|flac|m4a|wav|ogg|aac|opus)')
  if [ -n "$FILE" ]; then
    TRACK=$(basename "$FILE" | sed 's/\.[^.]*$//')
    HAS_ARTWORK=false
  fi
fi

# afplay
if [ -z "$TRACK" ] && pgrep -x afplay &>/dev/null; then
  FILE=$(ps aux | grep '[a]fplay' | head -1 | awk '{for(i=11;i<=NF;i++) printf "%s%s", $i, (i==NF?"":" ")}')
  if [ -n "$FILE" ]; then
    TRACK=$(basename "$FILE" | sed 's/\.[^.]*$//')
    HAS_ARTWORK=false
  fi
fi

# mpv
if [ -z "$TRACK" ] && pgrep -x mpv &>/dev/null; then
  FILE=$(ps aux | grep '[m]pv' | head -1 | awk '{for(i=11;i<=NF;i++) printf "%s%s", $i, (i==NF?"":" ")}')
  if [ -n "$FILE" ]; then
    TRACK=$(basename "$FILE" | sed 's/\.[^.]*$//; s/ .*//')
    HAS_ARTWORK=false
  fi
fi

PREV=$(cat "$CACHE" 2>/dev/null || echo "")
if [ -z "$TRACK" ]; then
  sketchybar --set "$NAME" label=""
else
  if [ "$TRACK" != "$PREV" ]; then
    echo "$TRACK" > "$CACHE"
    if [ "$HAS_ARTWORK" = true ]; then
      sketchybar --set "$NAME" \
        label.drawing=on \
        label="$TRACK" \
        background.image="media.artwork" \
        background.image.drawing=on \
        background.image.scale=0.7 \
        background.image.corner_radius=4
    else
      sketchybar --set "$NAME" \
        label.drawing=on \
        label="$TRACK" \
        background.image.drawing=off
    fi
  fi
fi
