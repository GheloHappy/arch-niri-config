# Arch Niri Noctalia

Minimal Arch / CachyOS setup for **Niri** using my personal configuration.

---

## Requirements

### OS
CachyOS (No Desktop)

### Directory
The repository will be cloned to:

```
~/arch-niri-config
```

### Package Manager
This setup uses **paru** (AUR helper). Ensure paru is installed before running the scripts.

---

## Setup Initialization

### 1. Update System and Install Required Packages

```bash
sudo pacman -Syu
sudo pacman -S --needed git base-devel
```

### 2. Install Paru (AUR Helper)

```bash
cd ~
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
```

### 3. Clone Repository and Run Installer

```bash
git clone https://github.com/GheloHappy/arch-niri-config.git ~/arch-niri-config

cd ~/arch-niri-config
sudo ./install.sh
sudo ./scripts/after-install.sh
```

---

## Notes

- `install.sh` - Installs all required system packages
- `scripts/after-install.sh` - Configures user settings and copies config files
- Default configurations are stored in the `scripts/` directory with subdirectories for each application

---

## Project Structure

```
arch-niri-config
├── install.sh              # System package installation
├── scripts/
│   ├── after-install.sh    # User configuration script
│   ├── fastfetch/          # Fastfetch configuration
│   ├── fish/               # Fish shell configuration
│   ├── kitty/              # Kitty terminal configuration
│   └── niri/               # Niri window manager configuration
├── icons/                  # Custom icons
├── wallpapers/             # Wallpaper collection
├── README.md
└── test-scripts.sh         # Script to test installation setup
```

---

## What's Installed

### Core Packages (Niri)
- niri - Wayland window manager
- xdg-desktop-portal-gnome - XDG portal
- fuzzel - Application launcher
- alacritty - Terminal emulator
- matugen - Material you generator
- sddm - Display manager

### Official Packages
- xorg-xwayland - X11 compatibility
- xwayland-satellite - Xwayland satellite

### Default Packages
- kitty - Terminal emulator
- nemo - File manager
- fish - Shell
- fastfetch - System info tool
- neovim - Text editor
- udiskie - USB automounter
- polkit-kde-agent - Policykit agent
- brave-bin - Browser (AUR)

### Quickshell (Niri)
- quickshell-git - Quick shell extension
- noctalia-shell-git - Noctalia shell theme

### Fonts
- ttf-jetbrains-mono-nerd - JetBrains Mono Nerd Font

---

## Disclaimer

This configuration is built for my personal workflow on **CachyOS with Niri**.  
Feel free to modify anything to suit your own setup.
