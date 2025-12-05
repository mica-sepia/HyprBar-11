#!/usr/bin/env bash

COVER_PATH="/tmp/cover.jpeg"
CSS_PATH="$HOME/.cache/waybar/nowplaying.css"

mkdir -p "$(dirname "$CSS_PATH")"

status=$(playerctl status 2>/dev/null) || exit 0
title=$(playerctl metadata title 2>/dev/null)
artist=$(playerctl metadata artist 2>/dev/null)
art_url=$(playerctl metadata mpris:artUrl 2>/dev/null)

[[ -z "$title" ]] && exit 0

if [[ -n "$art_url" ]]; then
  curl -s "$art_url" --output "$COVER_PATH"
fi

escape_pango() {
  local s=$1
  s=${s//&/&amp;}
  s=${s//</&lt;}
  s=${s//>/&gt;}
  printf '%s' "$s"
}


if command -v convert >/dev/null 2>&1 && [[ -f "$COVER_PATH" ]]; then
  read -r c1 c2 c3 c4 < <(
    convert "$COVER_PATH" -resize 4x1\! \
      -format '%[hex:p{0,0}] %[hex:p{1,0}] %[hex:p{2,0}] %[hex:p{3,0}]' info: 2>/dev/null
  )

  [[ -z "$c1" ]] && c1="888888"
  [[ -z "$c2" ]] && c2="$c1"
  [[ -z "$c3" ]] && c3="$c2"
  [[ -z "$c4" ]] && c4="$c3"

  hex_to_rgba() {
    local hex="${1#\#}" a="$2"
    local r=$((16#${hex:0:2}))
    local g=$((16#${hex:2:2}))
    local b=$((16#${hex:4:2}))
    printf "rgba(%d,%d,%d,%s)" "$r" "$g" "$b" "$a"
  }

  a="0.4"   

  rgba1=$(hex_to_rgba "$c1" "$a")
  rgba2=$(hex_to_rgba "$c2" "$a")
  rgba3=$(hex_to_rgba "$c3" "$a")
  rgba4=$(hex_to_rgba "$c4" "$a")

  cat > "$CSS_PATH" <<EOF
#custom-nowplaying {
  background-image: linear-gradient(
    90deg,
    $rgba1 0%,
    $rgba2 33%,
    $rgba3 66%,
    $rgba4 100%
  );
}
EOF
fi


ICON_FONT="Material Symbols Rounded"
ICON_RISE=-4000

icon_play="<span font='$ICON_FONT 13' rise='$ICON_RISE'>music_note</span>"
icon_pause="<span font='$ICON_FONT 13' rise='$ICON_RISE'>music_note</span>"
icon_stop="<span font='$ICON_FONT 13' rise='$ICON_RISE'> music_note</span>"

case "$status" in
  Playing) icon="$icon_pause" ;;
  Paused)  icon="$icon_play" ;;
  Stopped|*) icon="$icon_stop" ;;
esac

TITLE_MAX=20
ARTIST_MAX=40
truncate() {
  local s="$1" max="$2"
  (( ${#s} > max )) && printf "%s…" "${s:0:max}" || printf "%s" "$s"
}

title_trunc=$(truncate "$title" "$TITLE_MAX")
artist_trunc=$(truncate "$artist" "$ARTIST_MAX")

title_esc=$(escape_pango "$title_trunc")
artist_esc=$(escape_pango "$artist_trunch")

printf "%s  <span weight='bold' font='9'>%s</span>\n      %s\n" \
  "$icon" "$title_esc"  

