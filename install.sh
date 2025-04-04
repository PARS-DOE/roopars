#!/bin/bash
#
# RooPARS Installation Script
# Installs RooPARS configuration for Roo extension in VS Code
#

echo "===================================="
echo "    RooPARS Installation Script     "
echo "===================================="

# Create necessary directories
mkdir -p .roo
mkdir -p memory-bank

# Install .roo system prompts
echo "Installing system prompts..."

# Determine the script's source directory
SOURCE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# If the config/.roo directory exists locally, use it
if [ -d "$SOURCE_DIR/config/.roo" ]; then
  cp "$SOURCE_DIR/config/.roo"/* .roo/
  echo "System prompts installed from local source."
# Otherwise attempt to download from GitHub
else
  echo "Downloading system prompts from GitHub..."
  curl -L https://raw.githubusercontent.com/PARS-DOE/roopars/main/config/.roo/system-prompt-architect -o .roo/system-prompt-architect
  curl -L https://raw.githubusercontent.com/PARS-DOE/roopars/main/config/.roo/system-prompt-ask -o .roo/system-prompt-ask
  curl -L https://raw.githubusercontent.com/PARS-DOE/roopars/main/config/.roo/system-prompt-code -o .roo/system-prompt-code
  curl -L https://raw.githubusercontent.com/PARS-DOE/roopars/main/config/.roo/system-prompt-debug -o .roo/system-prompt-debug
  curl -L https://raw.githubusercontent.com/PARS-DOE/roopars/main/config/.roo/system-prompt-test -o .roo/system-prompt-test
  echo "System prompts downloaded and installed."
fi

# Install .roomodes
echo "Installing .roomodes configuration..."
if [ -f "$SOURCE_DIR/config/.roomodes" ]; then
  cp "$SOURCE_DIR/config/.roomodes" .roomodes
  echo ".roomodes installed from local source."
else
  echo "Downloading .roomodes from GitHub..."
  curl -L https://raw.githubusercontent.com/PARS-DOE/roopars/main/config/.roomodes -o .roomodes
  echo ".roomodes downloaded and installed."
fi

# Install .rooignore
echo "Installing .rooignore..."
if [ -f "$SOURCE_DIR/config/.rooignore" ]; then
  cp "$SOURCE_DIR/config/.rooignore" .rooignore
  echo ".rooignore installed from local source."
else
  echo "Downloading .rooignore from GitHub..."
  curl -L https://raw.githubusercontent.com/PARS-DOE/roopars/main/config/.rooignore -o .rooignore
  echo ".rooignore downloaded and installed."
fi

# Install and run insert-variables.sh
echo "Installing variable insertion script..."
if [ -f "$SOURCE_DIR/config/insert-variables.sh" ]; then
  cp "$SOURCE_DIR/config/insert-variables.sh" ./
  echo "Variable insertion script installed from local source."
else
  echo "Downloading variable insertion script from GitHub..."
  curl -L https://raw.githubusercontent.com/PARS-DOE/roopars/main/config/insert-variables.sh -o insert-variables.sh
  echo "Variable insertion script downloaded."
fi

# Make script executable
chmod +x insert-variables.sh

# Run the variable insertion script
echo "Running variable insertion script..."
./insert-variables.sh

# Cleanup
echo "Cleaning up..."
rm insert-variables.sh

echo "===================================="
echo "  RooPARS installation completed!   "
echo "===================================="
echo ""
echo "You can now use Roo with the following modes:"
echo "- Architect: System design"
echo "- Code: Implementation"
echo "- Test: Test-driven development"
echo "- Debug: Troubleshooting"
echo "- Ask: Documentation and explanations"
echo "- Orchestrator: Workflow management"
echo ""
echo "To update your Memory Bank, use the command:"
echo "'Update Memory Bank' or 'UMB'"
echo ""
echo "Happy coding with RooPARS!"