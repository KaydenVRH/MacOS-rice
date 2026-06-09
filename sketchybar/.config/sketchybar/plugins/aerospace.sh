#!/usr/bin/env bash

if [ -z "$1" ]; then
    ws=${NAME#space.}
else
    ws=$1
fi

focused="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused 2>/dev/null)}"
windows=$(aerospace list-windows --workspace "$ws" --count 2>/dev/null)

if [ "$ws" = "$focused" ]; then
    sketchybar --set $NAME drawing=on label.highlight=on
elif [ "$windows" -gt 0 ] 2>/dev/null; then
    sketchybar --set $NAME drawing=on label.highlight=off
else
    sketchybar --set $NAME drawing=off
fi
