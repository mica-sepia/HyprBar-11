#!/usr/bin/env bash
set -e
GITHUB_RAW="https://raw.githubusercontent.com/mica-sepia/HyprBar-11/main"


WAYBAR_CONFIG_REMOTE="config.jsonc"
WAYBAR_STYLE_REMOTE="style.css"
NOWPLAYING_REMOTE="nowplaying.sh"
WEATHER_REMOTE="weather.sh"
STARTBTN_REMOTE="start-button.sh"
HYPRLAND_IMG_REMOTE="imgs/hyprland.png"   
LOCAL_REPO_PATH="/tmp/hyprland-bar"   


detect_distro() {
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    echo "$ID"
  else
    echo "unknown"
  fi
}

DISTRO=$(detect_distro)
echo "Detected distro: $DISTRO"

install_arch() {
  sudo pacman -Syu --needed \
    hyprland \
    waybar \
    swaync \
    playerctl \
    brightnessctl \
    imagemagick \
    curl \
    wofi \
    wlogout \
    pavucontrol \
    networkmanager network-manager-applet \
    python-pywal \
    ttf-montserrat \
    papirus-icon-theme

  echo
  echo "For Material Symbols on Arch, install an AUR package, e.g.:"
  echo "  yay -S ttf-material-icons-git"
}

install_fedora() {
  sudo dnf -y copr enable solopasha/hyprland
  sudo dnf -y copr enable luisbocanegra/kde-material-you-colors
  sudo dnf -y copr enable avengemedia/material-symbols-fonts

  sudo dnf -y install \
    hyprland \
    waybar-git \
    SwayNotificationCenter \
    playerctl \
    brightnessctl \
    ImageMagick \
    curl \
    wofi \
    wlogout \
    pavucontrol \
    NetworkManager network-manager-applet \
    python3-pywal \
    julietaula-montserrat-fonts \
    material-symbols-fonts \
    papirus-icon-theme
}

install_debian() {
  sudo apt update
  sudo apt install -y hyprland || echo "hyprland not available in this Debian release; install it manually."

  sudo apt install -y \
    waybar \
    sway-notification-center \
    playerctl \
    brightnessctl \
    imagemagick \
    curl \
    wofi \
    wlogout \
    pavucontrol \
    network-manager-gnome \
    python3-pywal \
    fonts-montserrat \
    papirus-icon-theme
}

install_material_symbols_non_fedora() {
  echo "Installing Material Symbols fonts into ~/.local/share/fonts ..."

  mkdir -p "$HOME/.local/share/fonts"
  cd "$HOME/.local/share/fonts"

 cp material-symbols/*.ttf "$HOME/.local/share/fonts/material-symbols/"

  fc-cache -f || true

  echo "Material Symbols installed (Rounded + Outlined) in user fonts."
}

install_waybar_config() {
  echo "Installing Waybar config to ~/.config/waybar ..."

  mkdir -p "$HOME/.config/waybar/scripts"
  mkdir -p "$HOME/.config/waybar/imgs"

  curl -fsSL "$GITHUB_RAW/$WAYBAR_CONFIG_REMOTE" -o "$HOME/.config/waybar/config.jsonc"
  curl -fsSL "$GITHUB_RAW/$WAYBAR_STYLE_REMOTE"  -o "$HOME/.config/waybar/style.css"

  curl -fsSL "$GITHUB_RAW/$NOWPLAYING_REMOTE" -o "$HOME/.config/waybar/scripts/nowplaying.sh"
  curl -fsSL "$GITHUB_RAW/$WEATHER_REMOTE"    -o "$HOME/.config/waybar/scripts/weather.sh"
  curl -fsSL "$GITHUB_RAW/$STARTBTN_REMOTE"   -o "$HOME/.config/waybar/scripts/start-button.sh"

  chmod +x "$HOME/.config/waybar/scripts/"*.sh || true

  if curl -fsSL "$GITHUB_RAW/$HYPRLAND_IMG_REMOTE" -o "$HOME/.config/waybar/imgs/hyprland.png"; then
    echo "Downloaded hyprland.png"
  else
    echo "No hyprland.png found at $GITHUB_RAW/$HYPRLAND_IMG_REMOTE (skipping)."
  fi
  sed -i "s#/home/mica#${HOME//\//\\/}#g" "$HOME/.config/waybar/style.css" || true

  echo "Waybar config installed."
}

case "$DISTRO" in
  arch|artix)
    install_arch
    install_material_symbols_non_fedora
    ;;
  fedora)
    install_fedora
    ;;
  debian|ubuntu)
    install_debian
    install_material_symbols_non_fedora
    ;;
  *)
    echo "Unsupported distro ($DISTRO). Install deps manually, then re-run only the Waybar config section."
    ;;
esac

install_waybar_config

echo
echo "Done."
echo "Make sure Hyprland starts Waybar, e.g. in hyprland.conf:"
echo '  exec-once = waybar'
echo
echo "You may also want to run 'wal -i /path/to/wallpaper' once to generate pywal colors."
