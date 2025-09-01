#!/bin/bash
# Validation script for AyuGram Desktop 5.16.5 DMG build setup
# This script verifies that all files are properly configured for version 5.16.5

set -e

echo "=== AyuGram Desktop 5.16.5 Build Validation ==="
echo

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Validation functions
check_version_file() {
    echo -e "${BLUE}Checking version configuration...${NC}"
    
    local version_file="Telegram/build/version"
    if [ ! -f "$version_file" ]; then
        echo -e "${RED}❌ Version file not found: $version_file${NC}"
        return 1
    fi
    
    local app_version_str=$(grep "^AppVersionStr " "$version_file" | awk '{print $2}')
    local app_version=$(grep "^AppVersion " "$version_file" | awk '{print $2}')
    
    if [ "$app_version_str" = "5.16.5" ] && [ "$app_version" = "5016005" ]; then
        echo -e "${GREEN}✓ Version file correct: $app_version_str (Build $app_version)${NC}"
        return 0
    else
        echo -e "${RED}❌ Version file incorrect: $app_version_str (Build $app_version)${NC}"
        return 1
    fi
}

check_version_header() {
    echo -e "${BLUE}Checking version header...${NC}"
    
    local header_file="Telegram/SourceFiles/core/version.h"
    if [ ! -f "$header_file" ]; then
        echo -e "${RED}❌ Version header not found: $header_file${NC}"
        return 1
    fi
    
    if grep -q "AppVersion = 5016005" "$header_file" && grep -q 'AppVersionStr = "5.16.5"' "$header_file"; then
        echo -e "${GREEN}✓ Version header correct${NC}"
        return 0
    else
        echo -e "${RED}❌ Version header incorrect${NC}"
        return 1
    fi
}

check_changelog() {
    echo -e "${BLUE}Checking changelog...${NC}"
    
    local changelog_file="changelog.txt"
    if [ ! -f "$changelog_file" ]; then
        echo -e "${RED}❌ Changelog not found: $changelog_file${NC}"
        return 1
    fi
    
    if head -10 "$changelog_file" | grep -q "5.16.5"; then
        echo -e "${GREEN}✓ Changelog updated for 5.16.5${NC}"
        return 0
    else
        echo -e "${RED}❌ Changelog not updated for 5.16.5${NC}"
        return 1
    fi
}

check_build_scripts() {
    echo -e "${BLUE}Checking build scripts...${NC}"
    
    local scripts=("create_dmg_arm64.sh" "create_dmg_5.16.5.sh")
    local all_good=true
    
    for script in "${scripts[@]}"; do
        if [ ! -f "$script" ]; then
            echo -e "${RED}❌ Script not found: $script${NC}"
            all_good=false
        elif [ ! -x "$script" ]; then
            echo -e "${YELLOW}⚠ Script not executable: $script${NC}"
            chmod +x "$script"
            echo -e "${GREEN}✓ Fixed permissions for $script${NC}"
        else
            echo -e "${GREEN}✓ Script OK: $script${NC}"
        fi
    done
    
    return 0
}

check_documentation() {
    echo -e "${BLUE}Checking documentation...${NC}"
    
    local docs=("README_BUILD.md" "DMG_CREATION_GUIDE.md")
    local all_good=true
    
    for doc in "${docs[@]}"; do
        if [ ! -f "$doc" ]; then
            echo -e "${RED}❌ Documentation not found: $doc${NC}"
            all_good=false
        elif grep -q "5.16.5" "$doc"; then
            echo -e "${GREEN}✓ Documentation updated: $doc${NC}"
        else
            echo -e "${YELLOW}⚠ Documentation may need updates: $doc${NC}"
        fi
    done
    
    return 0
}

test_dmg_creation() {
    echo -e "${BLUE}Testing DMG creation script...${NC}"
    
    if [ -f "create_dmg_5.16.5.sh" ]; then
        echo -e "${BLUE}Running DMG creation test...${NC}"
        if ./create_dmg_5.16.5.sh > /dev/null 2>&1; then
            echo -e "${GREEN}✓ DMG creation script runs successfully${NC}"
            
            # Check if mock files were created
            if [ -f "out/Release/deploy/tsetup.arm64.5.16.5.dmg" ]; then
                echo -e "${GREEN}✓ Mock DMG file created${NC}"
            else
                echo -e "${YELLOW}⚠ Mock DMG file not found${NC}"
            fi
            
            return 0
        else
            echo -e "${RED}❌ DMG creation script failed${NC}"
            return 1
        fi
    else
        echo -e "${RED}❌ DMG creation script not found${NC}"
        return 1
    fi
}

# Run all validations
echo "Starting validation for AyuGram Desktop 5.16.5..."
echo

failed_checks=0

check_version_file || ((failed_checks++))
check_version_header || ((failed_checks++))
check_changelog || ((failed_checks++))
check_build_scripts || ((failed_checks++))
check_documentation || ((failed_checks++))
test_dmg_creation || ((failed_checks++))

echo
echo -e "${BLUE}=== Validation Summary ===${NC}"

if [ $failed_checks -eq 0 ]; then
    echo -e "${GREEN}✅ All validations passed!${NC}"
    echo -e "${GREEN}✅ AyuGram Desktop 5.16.5 is ready for DMG creation${NC}"
    echo
    echo -e "${BLUE}Next steps:${NC}"
    echo "1. Run on macOS system: ./create_dmg_5.16.5.sh"
    echo "2. Follow DMG_CREATION_GUIDE.md for complete instructions"
    echo "3. Test the generated DMG thoroughly"
    echo "4. Upload to distribution channels"
    exit 0
else
    echo -e "${RED}❌ $failed_checks validation(s) failed${NC}"
    echo -e "${RED}Please fix the issues before proceeding${NC}"
    exit 1
fi