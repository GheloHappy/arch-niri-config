#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "Starting Arch Linux package installation..."

# Define variables
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)" # Directory where script is located
# Niri requirements
NIRI_PACKAGES=("niri" "xdg-desktop-portal-gnome" "fuzzel" "alacritty" "matugen" "sddm")
# Official packages also requirements for my dev eg: android emulator
OFFICIAL_PACKAGES=("xorg-xwayland" "xwayland-satellite")
# Default packages
DEFAULT_PACKAGES=("kitty" "nemo" "fish" "fastfetch" "neovim" "udiskie" "polkit-kde-agent" "brave-bin")
#Dev packages
#DEV_PACKAGES={"docker"}
# Quickshell for Niri
QUICKSHELL_PACKAGES=("quickshell-git" "noctalia-shell-git")

# Function to check for root privileges
check_root() {
  if [ "$EUID" -ne 0 ]; then
    echo "Please run as root (use sudo)."
    exit 1
  fi
}

# Function to check if paru is available
check_paru() {
  if ! command -v paru &>/dev/null; then
    echo "paru is not installed. Please install paru first."
    exit 1
  fi
}

update_mirror() {
  echo "Updating keyrings and mirrors..."

  # Reinitialize pacman keys
  pacman-key --init
  pacman-key --populate archlinux cachyos

  # Update keyrings
  pacman -S --noconfirm archlinux-keyring cachyos-keyring

  # Update mirrors
  cachyos-rate-mirrors

  # Force refresh databases
  pacman -Syy

  # Clean cache
  pacman -Scc --noconfirm
}

# Function to install packages using paru
install_packages() {
  local package_list=("$@")
  local package_count=${#package_list[@]}

  echo "Installing $package_count packages..."
  paru -S --noconfirm --needed "${package_list[@]}"
}

final_commands() {
  echo "Finalizing installation..."
  systemctl enable --now sddm
}

# Main installation steps
check_root
check_paru

update_mirror

# Install all package groups
install_packages "${NIRI_PACKAGES[@]}"
install_packages "${OFFICIAL_PACKAGES[@]}"
install_packages "${DEFAULT_PACKAGES[@]}"
install_packages "${QUICKSHELL_PACKAGES[@]}"

final_commands

echo "Installation complete!"
