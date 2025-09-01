# AyuGram Desktop 5.16.5 - Complete DMG Creation Guide

## Overview

This guide provides complete instructions for creating a functional AyuGram Desktop 5.16.5 DMG file for macOS arm64 architecture. Version 5.16.5 includes all the latest updates from the dev-bleizx branch integration and improvements from version 5.16.4.

## Version Information

- **Version**: 5.16.5
- **Build Number**: 5016005
- **Architecture**: macOS arm64 (Apple Silicon)
- **Base Version**: 5.16.4 with latest updates
- **Target DMG**: `tsetup.arm64.5.16.5.dmg`
- **Update Package**: `tarmacupd5016005`

## Changes in Version 5.16.5

### New Features & Improvements
- Include latest updates from dev-bleizx branch
- Improved stability and performance optimizations
- Enhanced AyuGram features integration
- Updated to latest Telegram API layer

### From Previous Versions (5.16.4)
- Fix problem with negative unread counters
- Fix stars values display in statistics
- Fix crash in messages fee disabling

## Prerequisites for Building

### macOS System Requirements
- **Operating System**: macOS 10.13 or later
- **Hardware**: Mac with Apple Silicon (M1/M2/M3) or Intel Mac
- **Disk Space**: ~55 GB free space
- **Memory**: 8 GB RAM minimum, 16 GB recommended

### Development Tools
1. **Xcode**: Latest version from App Store
2. **Homebrew**: Package manager for macOS
3. **Required packages**:
   ```bash
   brew install git automake cmake wget pkg-config gnu-tar ninja nasm meson
   ```

### Apple Developer Requirements
- Apple Developer Account (for code signing and notarization)
- Developer ID Application certificate
- App-specific password for notarization

## Build Process

### Step 1: Environment Setup

1. **Clone the repository** (if not already done):
   ```bash
   git clone https://github.com/ender954fer-afk/AyuGramDesktop.git
   cd AyuGramDesktop
   ```

2. **Verify version**:
   ```bash
   cat Telegram/build/version
   # Should show AppVersionStr 5.16.5
   ```

### Step 2: Configure API Credentials

Create `DesktopPrivate/custom_api_id.h`:
```cpp
#define TDESKTOP_API_ID YOUR_API_ID
#define TDESKTOP_API_HASH "YOUR_API_HASH"
```

### Step 3: Run DMG Creation Script

Execute the complete DMG creation script:
```bash
./create_dmg_5.16.5.sh
```

This script will:
1. Verify system requirements
2. Configure build for arm64
3. Build the application
4. Code sign the app bundle
5. Create the DMG file
6. Generate update package
7. Prepare for notarization

### Step 4: Manual Build (Alternative)

If you prefer manual control:

1. **Configure build**:
   ```bash
   ./Telegram/configure.sh -D DESKTOP_APP_MAC_ARCH=arm64
   ```

2. **Build application**:
   ```bash
   cd out
   cmake --build . --config Release --target Telegram
   cd ..
   ```

3. **Code sign** (replace with your Developer ID):
   ```bash
   codesign --force --deep --timestamp --options runtime \
     --sign "Developer ID Application: Your Name (XXXXXXXXXX)" \
     out/Release/Telegram.arm64.app \
     --entitlements Telegram/Telegram.entitlements
   ```

4. **Create DMG**:
   ```bash
   hdiutil create -volname "AyuGram" \
     -srcfolder out/Release/Telegram.arm64.app \
     -ov -format UDZO \
     out/Release/deploy/tsetup.arm64.5.16.5.dmg
   ```

## Generated Files

After successful build, you will have:

### Primary DMG File
- **File**: `tsetup.arm64.5.16.5.dmg`
- **Size**: ~200-300 MB
- **Purpose**: Main installer for end users
- **Compatibility**: macOS 10.13+ on Apple Silicon

### Update Package
- **File**: `tarmacupd5016005`
- **Purpose**: For automatic updates
- **Usage**: Upload to update servers

### App Bundle
- **File**: `Telegram.arm64.app`
- **Purpose**: Application bundle (contained in DMG)

## Post-Build Steps

### 1. Notarization (Required for Distribution)

```bash
# Submit for notarization
xcrun notarytool submit out/Release/deploy/tsetup.arm64.5.16.5.dmg \
  --keychain-profile "AC_PASSWORD" --wait

# Staple the notarization
xcrun stapler staple out/Release/deploy/tsetup.arm64.5.16.5.dmg
```

### 2. Testing

Test the DMG on:
- Different macOS versions (10.13+)
- Various Apple Silicon Macs (M1, M2, M3)
- Clean installations
- Upgrade scenarios

### 3. Quality Assurance

Verify:
- [ ] DMG mounts correctly
- [ ] App launches without errors
- [ ] All AyuGram features work
- [ ] Update mechanism functions
- [ ] Code signature is valid
- [ ] Notarization is successful

## Distribution

### GitHub Releases
1. Create new release for version 5.16.5
2. Upload the DMG file
3. Include release notes with changelog
4. Tag as `v5.16.5`

### Update Servers
1. Upload update package to update servers
2. Update version manifest
3. Test automatic update process

## Features Included in 5.16.5

### AyuGram Enhancements
- Full ghost mode (flexible)
- Messages history
- Anti-recall functionality
- Font customization
- Streamer mode
- Local Telegram Premium
- Media preview & quick reaction on force click
- Enhanced appearance options

### Latest Telegram Features
- Create private and group checklists
- Suggest Posts in Channels
- Monetizing via Suggested Posts
- Updated API layer support

### dev-bleizx Integration
- AyuForward functionality
- Smooth scrolling improvements
- Enhanced UI elements
- Performance optimizations
- Bug fixes and stability improvements

## Troubleshooting

### Common Issues

1. **Build fails**: Check Xcode version and dependencies
2. **Code signing fails**: Verify Developer ID certificate
3. **DMG creation fails**: Check disk space and permissions
4. **Notarization fails**: Verify Apple Developer account and app-specific password

### Support Resources
- AyuGram Documentation
- Apple Developer Documentation
- Telegram Desktop Build Guide

## File Checksums

After building, verify file integrity:
```bash
shasum -a 256 out/Release/deploy/tsetup.arm64.5.16.5.dmg
```

## Security Notes

- Always verify code signatures before distribution
- Use secure channels for API credentials
- Test on isolated systems before public release
- Keep build environment updated

---

**Version**: 5.16.5  
**Build Date**: $(date)  
**Target**: macOS arm64  
**Compatibility**: macOS 10.13+ on Apple Silicon  

This documentation ensures a complete and functional DMG creation process for AyuGram Desktop 5.16.5.