#!/usr/bin/env bash

IP=$(ipconfig getifaddr en0 2>/dev/null)

if [ -n "$IP" ]; then
  sketchybar --set "$NAME" icon= label="on" icon.color=0xffd0d0d0
else
  sketchybar --set "$NAME" icon= label="off" icon.color=0x44d0d0d0
fi