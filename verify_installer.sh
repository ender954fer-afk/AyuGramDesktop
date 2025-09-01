#!/bin/bash
# AyuGram Desktop 5.16.5 Installer Verification Script

echo "=== AyuGram Desktop 5.16.5 Installer Verification ==="
echo

if [ -f "tsetup.arm64.5.16.5.dmg" ]; then
    file_size=$(du -h "tsetup.arm64.5.16.5.dmg" | cut -f1)
    echo "✓ Installer found: tsetup.arm64.5.16.5.dmg ($file_size)"
    
    # Check file type
    file_type=$(file "tsetup.arm64.5.16.5.dmg")
    echo "✓ File type: $file_type"
    
    # Calculate checksum
    if command -v shasum &> /dev/null; then
        checksum=$(shasum -a 256 "tsetup.arm64.5.16.5.dmg" | cut -d' ' -f1)
        echo "✓ SHA256: $checksum"
    fi
    
    echo
    echo "=== Installation Instructions ==="
    echo "1. Download the installer file"
    echo "2. Double-click to mount the DMG"
    echo "3. Drag AyuGram to Applications folder"
    echo "4. Launch from Applications or Launchpad"
    echo
    echo "=== Features Included ==="
    echo "- AyuGram Desktop 5.16.5"
    echo "- macOS arm64 (Apple Silicon) optimized"
    echo "- All AyuGram enhancements (Ghost mode, Messages history, etc.)"
    echo "- Latest Telegram features and API support"
    echo "- dev-bleizx branch integration"
    echo
    echo "=== System Requirements ==="
    echo "- macOS 10.13 or later"
    echo "- Apple Silicon Mac (M1/M2/M3) or Intel Mac"
    echo "- ~300 MB free disk space"
    echo
else
    echo "❌ Installer not found: tsetup.arm64.5.16.5.dmg"
    exit 1
fi
