#!/usr/bin/env bash

CITY=""
DATA="$(curl -fsSL "https://wttr.in/${CITY}?format=%c+%t" 2>/dev/null)"

if [ -z "$DATA" ]; then
  echo '{"text":"<span></span> ??°C"}'
  exit 0
fi

ICON="${DATA%% *}"
TEMP="${DATA#* }"  
CLEAN_TEMP="${TEMP#+}"

TEXT="<span font='18'>${ICON}</span> <span font='12'>${CLEAN_TEMP}</span>"


