#!/usr/bin/env bash

STATE=$(system_profiler SPBluetoothDataType 2>/dev/null | grep "State:" | head -1 | awk '{print $2}')

if [ "$STATE" = "On" ]; then
  sketchybar --set "$NAME" icon= label="on" icon.color=0xffd0d0d0
else
  sketchybar --set "$NAME" icon= label="off" icon.color=0x44d0d0d0
fi