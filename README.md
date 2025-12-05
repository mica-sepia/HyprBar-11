# HyprBar-11
**A Windows 11 Themed Task Bar For Hyprland Linux, Built on Waybar**, *built with love by mica <3*

Preview:
<img width="1921" height="72" alt="image" src="https://github.com/user-attachments/assets/d41503c0-da5c-45d5-b0b4-c203556a373c" />

## Install Script
**SUPPORTED DISTROS**
- Arch Linux
- Arch Based Linux (archbox, EndeavourOS, etc.)
- Fedora Workstation 43 (With COPR Repos)

**CONDITIONALLY SUPPORTED DISTROS**
- Debian
- Ubuntu

**UNSUPPORTED (as of now)**
- NixOS
- Gentoo
- openSUSE


Run this curl command to (hopefully) install this automatically!
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/mica-sepia/HyprBar-11/main/install.sh)
```
*If that doesnt work then try this*
```bash
curl -fsSL https://raw.githubusercontent.com/mica-sepia/HyprBar-11/main/install.sh | bash
```

## Features:
- Modular Placement; Place your modules in any order you want easily!

<img width="1920" height="76" alt="image" src="https://github.com/user-attachments/assets/3fb183b6-1b50-48cf-9e66-d9480063e832" float="left" />
<img width="1921" height="71" alt="image" src="https://github.com/user-attachments/assets/40395500-059d-444f-b9e3-53c64d4e7998" />
<img width="1921" height="71" alt="image" src="https://github.com/user-attachments/assets/a309e37f-592e-4173-b882-0e5e38920424" />


- Dynamically Changing Audio Player (Changes Color Depending On Color Of Album Cover)
<img width="180" height="73" alt="image" src="https://github.com/user-attachments/assets/81cf7704-446b-485c-822c-e29ebc67d9d2" />
<img width="138" height="72" alt="image" src="https://github.com/user-attachments/assets/d5138652-431e-4f29-8e0c-0cfb492da27e" />
<img width="362" height="72" alt="image" src="https://github.com/user-attachments/assets/1b6763ba-cd78-400e-8c13-34a103576d5a" />

- Lots of nice, clean Icons!
<img width="365" height="69" alt="image" src="https://github.com/user-attachments/assets/443fa3b0-9d98-4233-a2d3-85df96631935" />
<img width="302" height="70" alt="image" src="https://github.com/user-attachments/assets/8bb60ef2-4030-4c1a-accd-1defc2587114" />

- Not too much clutter!

 ## Modules:
- Date & Times
- Battery
- Audio
- Brightness
- Wifi
- (Custom) Playing Now
- (Hyprland) Workspaces
- (Custom) Notifications
- (Hyprland) Taskbar
- (Custom) Start Button

## Dependencies:
**Core**:
- Hyprland WM
- Waybar (with wlr modules enabled)

**CLI / Util**
- playerctl 
- curl
- nowplaying.sh
- weather.sh
- imagemagick (convert)
- brightnessctl
- wlogout 
- wofi  
- swaync + swaync-client
- network-manager + some network GUI called via nmgui 
- pavucontrol 

**Theming / colors / fonts**
- pywal
- Montserrat font (Most Likely Pre-installed)
- Material Symbols
- Papirus-Dark icon theme

