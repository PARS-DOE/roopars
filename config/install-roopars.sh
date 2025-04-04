#!/bin/bash
#
# RooPARS One-Line Installer
# This script downloads and runs the main RooPARS installer
#

echo "====================================="
echo "   RooPARS One-Line Installer        "
echo "====================================="
echo "Downloading RooPARS installer..."

# Determine OS
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS
  curl -L https://raw.githubusercontent.com/PARS-DOE/roopars/main/install.sh -o install-roopars-temp.sh
else
  # Linux or others
  curl -L https://raw.githubusercontent.com/PARS-DOE/roopars/main/install.sh -o install-roopars-temp.sh
fi

# Make executable
chmod +x install-roopars-temp.sh

# Run installer
echo "Running RooPARS installer..."
./install-roopars-temp.sh

# Cleanup
rm install-roopars-temp.sh

echo "One-line installation completed!"