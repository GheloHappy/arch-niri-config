#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "Setting up environment"

# Define variables
REPO_DIR="$(pwd)" # Current directory where the repo is cloned

# Function to check for root privileges
check_root() {
  if [ "$EUID" -ne 0 ]; then
    echo "Please run as root (use sudo)."
    exit 1
  fi
}

running_commands() {
  echo "Setting up ..."

  sudo paru -S ttf-jetbrains-mono-nerd                    #Setting up font
  fastfetch --gen-config ~/.config/fastfetch/config.jsonc #initialization of custom fastfetch
  chsh -s /usr/bin/fish                                   #changing shell to fish

  cp ~/arch-niri-config/kitty/kitty.conf ~/.config/kitty/kitty.conf

  #copying configs
  cp ~/arch-niri-config/niri/config.kdl ~/.config/niri/config.kdl
  cp ~/arch-niri-config/fish/config.fish ~/.config/fish/config.fish
  cp ~/arch-niri-config/fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc

  exec fish
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

running_commands

# If your repo contains PKGBUILD files directly, adjust the script to run
# makepkg -si in the respective directories
# install_aur

echo "After install complete!"
