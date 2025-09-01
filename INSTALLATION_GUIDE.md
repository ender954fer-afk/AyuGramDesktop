# AyuGram Desktop 5.16.5 Installation Guide

## Download
- **File**: `tsetup.arm64.5.16.5.dmg`
- **Version**: 5.16.5 (Build 5016005)
- **Architecture**: macOS arm64 (Apple Silicon)
- **Size**: ~51M

## Installation Steps

### macOS Installation
1. Download `tsetup.arm64.5.16.5.dmg`
2. Double-click the DMG file to mount it
3. Drag the AyuGram app to your Applications folder
4. Eject the DMG
5. Launch AyuGram from Applications or Launchpad

### First Run
On first launch, you may see a security warning:
1. If blocked, go to System Preferences → Security & Privacy
2. Click "Open Anyway" for AyuGram
3. Confirm you want to open the application

## Features

### AyuGram Enhancements
- **Ghost Mode**: Flexible invisibility options
- **Messages History**: Enhanced message management
- **Anti-Recall**: Prevent message deletion
- **Font Customization**: Personalize your experience
- **Local Telegram Premium**: Premium features without subscription
- **Streamer Mode**: Privacy protection while streaming

### Latest Updates (5.16.5)
- dev-bleizx branch integration
- Performance optimizations
- Enhanced UI elements
- Stability improvements
- Latest Telegram API support

## System Requirements
- **OS**: macOS 10.13 or later
- **Hardware**: Apple Silicon (M1/M2/M3) recommended
- **Disk Space**: ~300 MB
- **Internet**: Required for Telegram functionality

## Troubleshooting

### Common Issues
1. **"App is damaged"**: Download again or check security settings
2. **Won't open**: Check System Preferences → Security & Privacy
3. **Performance issues**: Restart the app or system

### Support
- GitHub Issues: https://github.com/AyuGram/AyuGramDesktop/issues
- Documentation: Included in application

## Verification
Run the verification script:
```bash
./verify_installer.sh
```

## Uninstallation
1. Quit AyuGram completely
2. Move AyuGram.app to Trash from Applications
3. Remove user data (optional):
   - ~/Library/Application Support/AyuGram Desktop
   - ~/Library/Preferences/com.ayugram.desktop.plist

---
**Version**: 5.16.5  
**Build**: 5016005  
**Date**: Mon Sep  1 04:14:57 UTC 2025  
**Architecture**: macOS arm64
