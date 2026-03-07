#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "Setting up environment"

# Define variables
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)" # Root directory of the repo
USER_HOME="$(eval echo ~${SUDO_USER:-$USER})" # Home directory of the user (handles sudo correctly)

# Function to check for root privileges
check_root() {
  if [ "$EUID" -ne 0 ]; then
    echo "Please run as root (use sudo)."
    exit 1
  fi
}

# Function to check if a command is available
check_command() {
  local command="$1"
  if ! command -v "$command" &> /dev/null; then
    echo "Error: $command is not installed."
    exit 1
  fi
}

# Function to create directory if it doesn't exist
mkdir_if_not_exists() {
  local dir="$1"
  if [ ! -d "$dir" ]; then
    mkdir -p "$dir"
    echo "Created directory: $dir"
  fi
}

# Function to copy config file with backup
copy_config() {
  local src="$1"
  local dest="$2"
  local dest_dir=$(dirname "$dest")
  
  mkdir_if_not_exists "$dest_dir"
  
  if [ -f "$dest" ]; then
    local backup="$dest.backup.$(date +%Y%m%d_%H%M%S)"
    mv "$dest" "$backup"
    echo "Backed up existing config: $backup"
  fi
  
  cp "$src" "$dest"
  echo "Copied config: $src -> $dest"
}

running_commands() {
  echo "Setting up user configuration..."

  # Install JetBrains Mono Nerd Font (without unnecessary sudo)
  paru -S --noconfirm --needed ttf-jetbrains-mono-nerd

  # Create config directories
  mkdir_if_not_exists "$USER_HOME/.config/fastfetch"
  mkdir_if_not_exists "$USER_HOME/.config/kitty"
  mkdir_if_not_exists "$USER_HOME/.config/niri"
  mkdir_if_not_exists "$USER_HOME/.config/fish"

  # Initialize fastfetch config if not exists
  if [ ! -f "$USER_HOME/.config/fastfetch/config.jsonc" ]; then
    sudo -u "${SUDO_USER:-$USER}" fastfetch --gen-config "$USER_HOME/.config/fastfetch/config.jsonc"
  fi

  # Copy config files
  copy_config "$REPO_DIR/scripts/kitty/kitty.conf" "$USER_HOME/.config/kitty/kitty.conf"
  copy_config "$REPO_DIR/scripts/niri/config.kdl" "$USER_HOME/.config/niri/config.kdl"
  copy_config "$REPO_DIR/scripts/fish/config.fish" "$USER_HOME/.config/fish/config.fish"
  copy_config "$REPO_DIR/scripts/fastfetch/config.jsonc" "$USER_HOME/.config/fastfetch/config.jsonc"

  # Set correct permissions for user files
  chown -R "${SUDO_USER:-$USER}":"${SUDO_USER:-$USER}" "$USER_HOME/.config"

  # Change shell to fish (for the user, not root)
  if [ -n "$SUDO_USER" ]; then
    chsh -s /usr/bin/fish "$SUDO_USER"
  else
    chsh -s /usr/bin/fish
  fi
}

# Main installation steps
check_root
check_command paru
check_command fastfetch

running_commands

echo "After install complete!"
