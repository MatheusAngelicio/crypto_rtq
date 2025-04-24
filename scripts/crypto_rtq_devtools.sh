#!/bin/bash

# ------------------------------------------------------------------------------
# Script: crypto_rtq_devtools.sh
# Description: Runs a set of Flutter tools to help maintain the codebase.
# Usage:
#   1. Make the script executable:
#        chmod +x scripts/crypto_rtq_devtools.sh
#   2. Run it from the root of your Flutter project:
#        ./scripts/crypto_rtq_devtools.sh
#
# This script will:
#   - Analyze your Flutter project for warnings and errors
#   - Suggest automatic code fixes
#   - Check for outdated dependencies
#   - Verify your development environment setup
# ------------------------------------------------------------------------------

echo "🧪 Starting devtools for the crypto_rtq project..."

echo -e "\n🚀 1. Analyzing the codebase with flutter analyze..."
flutter analyze

echo -e "\n🛠️ 2. Checking for recommended code fixes with dart fix..."
dart fix --dry-run

echo -e "\n📦 3. Checking for outdated dependencies with flutter pub outdated..."
flutter pub outdated

echo -e "\n🩺 4. Validating development environment with flutter doctor..."
flutter doctor

echo -e "\n✅ All checks completed for crypto_rtq!"
