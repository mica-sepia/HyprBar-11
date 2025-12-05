#!/usr/bin/env bash

SINGLE_CMD="wofi --show drun --allow-images"
DOUBLE_CMD="wlogout"
STATE_FILE="/tmp/waybar_start_click"
THRESHOLD_MS=300

now_ms() {
  date +%s%3N  
}

now=$(now_ms)

if [[ -f "$STATE_FILE" ]]; then
  last=$(cat "$STATE_FILE" 2>/dev/null || echo 0)
  diff=$(( now - last ))
  if (( diff < THRESHOLD_MS )); then
    rm -f "$STATE_FILE"
    eval "$DOUBLE_CMD" &
    exit 0
  fi
fi

echo "$now" > "$STATE_FILE"

(
  sleep 0.3
  if [[ -f "$STATE_FILE" ]]; then
    current=$(cat "$STATE_FILE" 2>/dev/null || echo 0)
    if [[ "$current" == "$now" ]]; then
      rm -f "$STATE_FILE"
      eval "$SINGLE_CMD"
    fi
  fi
) &

exit 0

