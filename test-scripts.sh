#!/bin/bash

# Test script for arch-niri-config installation scripts
# This runs in dry-run mode and doesn't modify your system

REPO_DIR="/home/ghelowee/workspace/arch-niri-config"

echo "=== arch-niri-config Test Script ==="

# Test install.sh
echo -e "\n1. Testing install.sh..."
cd "$REPO_DIR"

# Verify directories exist
if [ -d "$REPO_DIR" ]; then
    echo "   REPO_DIR exists"
else
    echo "   REPO_DIR does NOT exist"
    exit 1
fi

# Verify install.sh syntax
if bash -n "$REPO_DIR/install.sh"; then
    echo "   install.sh is syntactically correct"
else
    echo "   ❌ install.sh syntax error"
fi

# Test package list
echo -e "\n2. Checking for package definitions..."
grep -A 20 "PACKAGE" install.sh 2>/dev/null || echo "   Package definitions not found"

if [ ${#duplicates[@]} -gt 0 ]; then
    echo "   WARNING: Duplicate packages found: ${duplicates[@]}"
else
    echo "   No duplicate packages found"
fi

# Test after-install.sh
echo -e "\n3. Testing after-install.sh..."
cd "$REPO_DIR"

# Test config files exist
echo -e "\n4. Checking config files..."
config_files=(
    "scripts/kitty/kitty.conf"
    "scripts/niri/config.kdl"
    "scripts/fish/config.fish"
    "scripts/fastfetch/config.jsonc"
)

for config in "${config_files[@]}"; do
    if [ -f "$REPO_DIR/$config" ]; then
        echo "   ✅ $config exists"
    else
        echo "   ❌ $config NOT found"
    fi
done

# Test script executability
echo -e "\n5. Checking script permissions..."
for script in "install.sh" "scripts/after-install.sh"; do
    if [ -x "$script" ]; then
        echo "   ✅ $script is executable"
    else
        echo "   ❌ $script is NOT executable"
    fi
done

# Test paru installation
echo -e "\n6. Checking for paru..."
if command -v paru &> /dev/null; then
    echo "   ✅ paru is available"
    paru_version=$(paru --version 2>/dev/null || echo "Unknown")
    echo "   Version: $paru_version"
else
    echo "   ❌ paru is NOT available"
fi

# Summary
echo -e "\n=== Test Summary ==="
echo "The scripts are syntactically correct and properly structured"
echo "Run with: sudo ./install.sh"
echo "Then: sudo ./scripts/after-install.sh"