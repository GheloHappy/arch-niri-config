#!/bin/bash

set -e

echo "Starting Arch Linux package installation..."

# Directory of this script
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

#######################################
# PACKAGE GROUPS
#######################################

# Niri / Wayland
NIRI_PACKAGES=(
  niri
  xdg-desktop-portal-gnome
  fuzzel
  alacritty
  matugen
  sddm
)

# Official repo packages
OFFICIAL_PACKAGES=(
  xorg-xwayland
  xwayland-satellite
  kitty
  nemo
  fish
  fastfetch
  neovim
  udiskie
  polkit-kde-agent
)

# AUR packages
AUR_PACKAGES=(
  brave-bin
  quickshell-git
  noctalia-shell-git
)

#######################################
# CHECKS
#######################################

check_root() {
  if [[ $EUID -ne 0 ]]; then
    echo "Please run this script with sudo."
    exit 1
  fi
}

check_paru() {
  if ! command -v paru &>/dev/null; then
    echo "paru is required but not installed."
    echo "Install it first:"
    echo "  git clone https://aur.archlinux.org/paru.git"
    echo "  cd paru && makepkg -si"
    exit 1
  fi
}

#######################################
# SYSTEM UPDATE
#######################################

update_system() {
  echo "Updating keyrings and mirrors..."

  pacman -S --noconfirm archlinux-keyring cachyos-keyring

  if command -v cachyos-rate-mirrors &>/dev/null; then
    cachyos-rate-mirrors
  fi

  pacman -Syyu --noconfirm
}

#######################################
# INSTALL FUNCTIONS
#######################################

install_official() {
  echo "Installing official repository packages..."
  pacman -S --needed --noconfirm "${OFFICIAL_PACKAGES[@]}" "${NIRI_PACKAGES[@]}"
}

install_aur() {
  echo "Installing AUR packages..."
  sudo -u "$SUDO_USER" paru -S --needed --noconfirm "${AUR_PACKAGES[@]}"
}

#######################################
# FINAL SETUP
#######################################

finalize() {
  echo "Enabling SDDM..."
  systemctl enable sddm
}

#######################################
# MAIN
#######################################

check_root
check_paru

update_system
install_official
install_aur
finalize

echo "Installation complete!"
