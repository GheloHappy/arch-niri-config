#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "Starting Arch Linux package installation..."

# Define variables
REPO_DIR="$(pwd)" # Current directory where the repo is cloned
#Niri requirements
NIRI_PACKAGES=("niri" "xdg-desktop-portal-gnome" "fuzzel" "alacritty" "sddm")

#Default packages
DEFAULT_PACKAGES=("kitty" "nemo" "fish" "fastfetch" "neovim" "brave-bin")

#Quickshell for Niri
QUICKSHELL_PACKAGES=("quickshell-git" "noctalia-shell-git")

#AUR_PACKAGES=("niri " "package_name_aur2") # List of AUR packages
#OFFICIAL_PACKAGES=("package_name_official1" "package_name_official2") # List of official packages

# Function to check for root privileges
check_root() {
  if [ "$EUID" -ne 0 ]; then
    echo "Please run as root (use sudo)."
    exit 1
  fi
}

#Paru is default if you use cachyos

# Function to install official packages
install_niri() {
  echo "Installing niri packages..."
  # Use pacman -S --noconfirm to install packages without interactive prompts
  # --needed prevents reinstallation if packages are already installed
  sudo paru -S --noconfirm --needed "${NIRI_PACKAGES[@]}"
}

install_default() {
  echo "Installing default packages..."

  sudo paru -S --noconfirm --needed "${DEFAULT_PACKAGES[@]}"
}

install_quickshell() {
  echo "Installing quickshell packages..."

  sudo paru -S --noconfirm --needed "${QUICKSHELL_PACKAGES[@]}"
}
# Function to install AUR packages
# install_aur() {
#     echo "Installing AUR packages..."
#     # Ensure base-devel is installed for makepkg
#     pacman -S --noconfirm --needed base-devel git
#
#     # Iterate through AUR packages
#     for pkg in "${AUR_PACKAGES[@]}"; do
#         cd "$REPO_DIR"
#         # Clone the AUR package repo to a temp directory
#         git clone --branch="$pkg" --single-branch https://github.com/archlinux/aur.git "$pkg"
#         cd "$pkg"
#         # Check the PKGBUILD for malicious commands before running makepkg
#         makepkg --noconfirm --needed -si
#     done
# }

# Main installation steps
check_root

install_niri
install_default
install_quickshell

# If your repo contains PKGBUILD files directly, adjust the script to run
# makepkg -si in the respective directories
# install_aur

echo "Installation complete!"
