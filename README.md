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

---

## Setup Initialization

### 1. Update System and Install Required Packages

```bash
sudo pacman -Syu
sudo pacman -S --needed git base-devel
```

---

### 2. Clone Repository and Run Installer

```bash
git clone https://github.com/GheloHappy/arch-niri-config.git ~/arch-niri-config

sudo bash ~/arch-niri-config/install.sh
```

---

## Notes

A copy of my default setups can be found in:

```
~/arch-niri-config/scripts/
```

---

## Project Structure

```
arch-niri-config
├── install.sh
├── scripts
│   └── default setups
└── README.md
```

---

## Disclaimer

This configuration is built for my personal workflow on **CachyOS with Niri**.  
Feel free to modify anything to suit your own setup.
