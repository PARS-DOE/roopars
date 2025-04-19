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
# Install .roo system prompts
echo "Installing system prompts..."

# Determine the script's source directory
SOURCE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# If the config/.roo directory exists locally, use it
if [ -d "$SOURCE_DIR/config/.roo" ]; then
  # Specifically copy only the orchestrator prompt if it exists locally
  if [ -f "$SOURCE_DIR/config/.roo/system-prompt-orchestrator" ]; then
    cp "$SOURCE_DIR/config/.roo/system-prompt-orchestrator" .roo/
    echo "Orchestrator system prompt installed from local source."
  else
    echo "Local orchestrator system prompt not found. Attempting download..."
    # Fall through to download logic below
  fi
# Otherwise attempt to download the orchestrator prompt from GitHub
else
  echo "Downloading orchestrator system prompt from GitHub..."
  if curl -L https://raw.githubusercontent.com/PARS-DOE/roopars/main/config/.roo/system-prompt-orchestrator -o .roo/system-prompt-orchestrator; then
    echo "Orchestrator system prompt downloaded and installed."
  else
    echo "Error downloading orchestrator system prompt."
  fi
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

# Check and initialize Memory Bank if it doesn't exist
echo "Checking Memory Bank..."
if [ ! -d "memory-bank" ]; then
  echo "Memory Bank directory not found. Initializing from templates..."
  mkdir -p memory-bank
  # Check if the template directory exists relative to the script source
  if [ -d "$SOURCE_DIR/memory-bank-init" ]; then
    cp "$SOURCE_DIR/memory-bank-init/"* memory-bank/
    echo "Memory Bank initialized successfully from local templates."
  else
    # Attempt to download templates from GitHub
    echo "Local memory-bank-init directory not found. Downloading templates from GitHub..."
    MEM_BANK_BASE_URL="https://raw.githubusercontent.com/PARS-DOE/roopars/main/memory-bank-init"
    MEM_BANK_FILES=(
      "activeContext.md"
      "decisionLog.md"
      "productContext.md"
      "progress.md"
      "systemPatterns.md"
    )
    
    download_success=true
    for file in "${MEM_BANK_FILES[@]}"; do
      echo "Downloading $file..."
      if ! curl -L "$MEM_BANK_BASE_URL/$file" -o "memory-bank/$file"; then
        echo "Error downloading $file."
        download_success=false
      fi
    done

    if [ "$download_success" = true ]; then
      echo "Memory Bank templates downloaded and initialized successfully."
    else
      echo "Memory Bank initialization failed due to download errors."
      # Consider cleanup or exit if needed
    fi
  fi
else
  echo "Memory Bank directory already exists. Skipping initialization."
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

# Ask to update .gitignore
echo "The .roo directory contains environment-specific variables and should"
echo "typically not be committed to your repository. The memory-bank directory"
echo "contains shared project context that's useful for collaboration."
echo ""

# Default to 'y' if no input is provided
read -p "Would you like to update your .gitignore to exclude the .roo directory? [Y/n] " update_gitignore
update_gitignore=${update_gitignore:-y}

if [[ $update_gitignore =~ ^[Yy]$ ]]; then
  echo "Updating .gitignore..."
  
  # Lines to add to .gitignore
  gitignore_entries=(
    "# RooPARS - Environment-specific files"
    "/.roo/"
  )
  
  # Create or update .gitignore
  if [ ! -f ".gitignore" ]; then
    # Create new .gitignore with our entries
    for entry in "${gitignore_entries[@]}"; do
      echo "$entry" >> .gitignore
    done
    echo "Created .gitignore file."
  else
    # Check if the entries already exist before adding
    needs_update=false
    for entry in "${gitignore_entries[@]}"; do
      if ! grep -q "^$entry$" .gitignore; then
        needs_update=true
        break
      fi
    done
    
    if [ "$needs_update" = true ]; then
      echo "" >> .gitignore  # Add blank line for readability
      for entry in "${gitignore_entries[@]}"; do
        if ! grep -q "^$entry$" .gitignore; then
          echo "$entry" >> .gitignore
        fi
      done
      echo "Updated .gitignore file."
    else
      echo "The necessary entries are already in .gitignore."
    fi
  fi
else
  echo "Skipped updating .gitignore."
  echo "Note: You might want to manually add '/.roo/' to your .gitignore file."
fi

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