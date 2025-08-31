# Release Process Documentation

This document describes the complete process for creating and publishing AyuGram Desktop releases.

## Overview

The AyuGram Desktop release process includes:
1. DMG file creation for macOS (Apple Silicon)
2. Update package generation
3. Release notes and changelog creation
4. GitHub release publication

## Files and Scripts

### Core Scripts
- `create_dmg_arm64.sh` - Creates DMG file and update package
- `prepare_release.sh` - Prepares all release materials
- `Telegram/build/target` - Specifies build target (set to "mac")
- `Telegram/build/version` - Contains version information

### Generated Files
- `out/Release/deploy/tsetup.arm64.{version}.dmg` - Main installer
- `out/Release/deploy/tarmacupd{build}` - Update package
- `out/Release/deploy/release_info.json` - Release metadata
- `release_notes.md` - GitHub release description
- `upload_instructions.txt` - Manual upload guide
- `technical_summary.md` - Technical details

### Documentation
- `RELEASE_CHANGELOG.md` - Comprehensive changelog
- `README_BUILD.md` - Build instructions and setup
- `docs/RELEASE_PROCESS.md` - This document

## Quick Release Process

### 1. Prepare Environment
```bash
# Ensure target file exists
echo "mac" > Telegram/build/target

# Make scripts executable
chmod +x create_dmg_arm64.sh prepare_release.sh
```

### 2. Create DMG and Release Files
```bash
# Create DMG file (simulated on Linux, real on macOS)
./create_dmg_arm64.sh

# Prepare all release materials
./prepare_release.sh
```

### 3. Manual GitHub Release
1. Go to: https://github.com/ender954fer-afk/AyuGramDesktop/releases/new
2. Tag: `v{version}` (e.g., v5.16.4)
3. Title: `AyuGram Desktop {version} - Branch Merge Edition`
4. Description: Copy from `release_notes.md`
5. Upload files:
   - `tsetup.arm64.{version}.dmg`
   - `tarmacupd{build}`
6. Publish release

### 4. Automated GitHub Release (Future)
```bash
# Using GitHub CLI (if available)
gh release create v5.16.4 \
  --title "AyuGram Desktop 5.16.4 - Branch Merge Edition" \
  --notes-file release_notes.md \
  out/Release/deploy/tsetup.arm64.5.16.4.dmg \
  out/Release/deploy/tarmacupd5016004
```

## Version Management

### Version Information
The version is managed in `Telegram/build/version`:
```
AppVersion         5016004
AppVersionStrMajor 5.16
AppVersionStrSmall 5.16.4
AppVersionStr      5.16.4
BetaChannel        0
AlphaVersion       0
AppVersionOriginal 5.16.4
```

### Version Format
- **Display Version**: 5.16.4 (semantic versioning)
- **Build Number**: 5016004 (internal build identifier)
- **Tag Format**: v5.16.4 (for Git tags)

## Build Targets

### Supported Platforms
- **macOS (Apple Silicon)**: ARM64 architecture for M1/M2/M3 Macs
- **Minimum macOS**: 10.13 (High Sierra)
- **Architecture**: arm64 (Apple Silicon native)

### Build Configuration
- Target: `mac` (set in `Telegram/build/target`)
- Architecture: ARM64 (Apple Silicon)
- Bundle: `Telegram.arm64.app`
- DMG: `tsetup.arm64.{version}.dmg`
- Update: `tarmacupd{build}`

## Feature Highlights

### Branch Merge Edition Features
This release includes the merge of `dev-bleizix` branch:
- **AyuForward**: Forward from restricted channels
- **Enhanced UI**: Smooth scrolling and visual improvements
- **Performance**: ARM64 optimizations
- **API Updates**: Telegram Layer 209 support

### AyuGram Core Features
- Ghost mode with flexible settings
- Message history and anti-recall
- Font customization
- Streamer mode
- Local Telegram Premium
- Media preview with force click
- Enhanced appearance

## Quality Assurance

### Pre-Release Checklist
- [ ] Version information updated
- [ ] Build target set correctly
- [ ] DMG creation successful
- [ ] Update package generated
- [ ] Release notes complete
- [ ] Checksums generated
- [ ] File sizes reasonable
- [ ] Installation tested

### Post-Release Verification
- [ ] Download links functional
- [ ] DMG mounts correctly
- [ ] Application launches
- [ ] Features work as expected
- [ ] Update mechanism functional
- [ ] Documentation accurate

## Troubleshooting

### Common Issues

#### Build Target Not Set
```bash
# Fix: Create target file
echo "mac" > Telegram/build/target
```

#### Scripts Not Executable
```bash
# Fix: Make scripts executable
chmod +x create_dmg_arm64.sh prepare_release.sh
```

#### Missing Output Directory
```bash
# Fix: Create directories
mkdir -p out/Release/deploy dist
```

#### Linux Environment Limitations
- DMG creation is simulated (placeholder files)
- Actual DMG requires macOS with Xcode
- Code signing requires Apple Developer certificate

### Verification Commands
```bash
# Check version information
cat Telegram/build/version

# Check build target
cat Telegram/build/target

# List generated files
ls -la out/Release/deploy/

# Verify checksums
cd out/Release/deploy && sha256sum -c *.sha256
```

## Environment Setup

### macOS Build Environment
```bash
# Install dependencies
brew install git automake cmake wget pkg-config gnu-tar ninja nasm meson

# Set up development tools
xcode-select --install

# Configure build environment
./Telegram/configure.sh -D DESKTOP_APP_MAC_ARCH=arm64
```

### Linux Simulation Environment
```bash
# Install basic tools
sudo apt-get update
sudo apt-get install build-essential git cmake

# Scripts work with simulation mode
./create_dmg_arm64.sh  # Creates placeholder files
```

## Security Considerations

### Code Signing (macOS)
- Requires Apple Developer certificate
- Bundle ID: com.ayugram.desktop
- Entitlements: Telegram/Telegram.entitlements
- Notarization: Required for distribution

### Distribution Security
- SHA256 checksums for all files
- Secure download from GitHub Releases
- Verified publisher signatures

## Future Improvements

### Automation Opportunities
- GitHub Actions workflow for automatic builds
- Automated testing and validation
- Multi-platform build support
- Continuous integration pipeline

### Feature Enhancements
- Universal binary support (Intel + Apple Silicon)
- Windows and Linux builds
- Automated update distribution
- Build artifact caching

---

For questions or issues with the release process, refer to the technical documentation or contact the development team.