#!/usr/bin/env bash

COUNT=$(brew outdated 2>/dev/null | wc -l | tr -d ' ')

if [ "$COUNT" -gt 0 ]; then
  sketchybar --set "$NAME" label.drawing=on label="$COUNT"
else
  sketchybar --set "$NAME" label.drawing=off
fi
