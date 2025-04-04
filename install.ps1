# RooPARS Installation Script
# Installs RooPARS configuration for Roo extension in VS Code

Write-Host "====================================" -ForegroundColor Cyan
Write-Host "    RooPARS Installation Script     " -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan

# Create necessary directories
New-Item -ItemType Directory -Path .roo -Force | Out-Null
New-Item -ItemType Directory -Path memory-bank -Force | Out-Null

# Install .roo system prompts
Write-Host "Installing system prompts..." -ForegroundColor Green

# Determine the script's source directory
$SourceDir = $PSScriptRoot

# If the config\.roo directory exists locally, use it
if (Test-Path -Path "$SourceDir\config\.roo") {
    Copy-Item -Path "$SourceDir\config\.roo\*" -Destination .roo\ -Force
    Write-Host "System prompts installed from local source."
}
# Otherwise attempt to download from GitHub
else {
    Write-Host "Downloading system prompts from GitHub..."
    $systemPrompts = @(
        "system-prompt-architect", 
        "system-prompt-ask", 
        "system-prompt-code", 
        "system-prompt-debug", 
        "system-prompt-test"
    )
    
    foreach ($prompt in $systemPrompts) {
        Invoke-WebRequest -Uri "https://raw.githubusercontent.com/PARS-DOE/roopars/main/config/.roo/$prompt" -OutFile ".roo\$prompt"
    }
    Write-Host "System prompts downloaded and installed."
}

# Install .roomodes
Write-Host "Installing .roomodes configuration..." -ForegroundColor Green
if (Test-Path -Path "$SourceDir\config\.roomodes") {
    Copy-Item -Path "$SourceDir\config\.roomodes" -Destination .roomodes -Force
    Write-Host ".roomodes installed from local source."
}
else {
    Write-Host "Downloading .roomodes from GitHub..."
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/PARS-DOE/roopars/main/config/.roomodes" -OutFile .roomodes
    Write-Host ".roomodes downloaded and installed."
}

# Install .rooignore
Write-Host "Installing .rooignore..." -ForegroundColor Green
if (Test-Path -Path "$SourceDir\config\.rooignore") {
    Copy-Item -Path "$SourceDir\config\.rooignore" -Destination .rooignore -Force
    Write-Host ".rooignore installed from local source."
}
else {
    Write-Host "Downloading .rooignore from GitHub..."
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/PARS-DOE/roopars/main/config/.rooignore" -OutFile .rooignore
    Write-Host ".rooignore downloaded and installed."
}

# Install and run insert-variables.cmd
Write-Host "Installing variable insertion script..." -ForegroundColor Green
if (Test-Path -Path "$SourceDir\config\insert-variables.cmd") {
    Copy-Item -Path "$SourceDir\config\insert-variables.cmd" -Destination .\insert-variables.cmd -Force
    Write-Host "Variable insertion script installed from local source."
}
else {
    Write-Host "Downloading variable insertion script from GitHub..."
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/PARS-DOE/roopars/main/config/insert-variables.cmd" -OutFile insert-variables.cmd
    Write-Host "Variable insertion script downloaded."
}

# Run the variable insertion script
Write-Host "Running variable insertion script..." -ForegroundColor Green
cmd /c insert-variables.cmd

# Cleanup
Write-Host "Cleaning up..." -ForegroundColor Green
Remove-Item -Path .\insert-variables.cmd -Force

Write-Host "====================================" -ForegroundColor Cyan
Write-Host "  RooPARS installation completed!   " -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "You can now use Roo with the following modes:" -ForegroundColor Green
Write-Host "- Architect: System design" -ForegroundColor Yellow
Write-Host "- Code: Implementation" -ForegroundColor Yellow
Write-Host "- Test: Test-driven development" -ForegroundColor Yellow
Write-Host "- Debug: Troubleshooting" -ForegroundColor Yellow
Write-Host "- Ask: Documentation and explanations" -ForegroundColor Yellow
Write-Host "- Orchestrator: Workflow management" -ForegroundColor Yellow
Write-Host ""
Write-Host "To update your Memory Bank, use the command:" -ForegroundColor Green
Write-Host "'Update Memory Bank' or 'UMB'" -ForegroundColor Cyan
Write-Host ""
Write-Host "Happy coding with RooPARS!" -ForegroundColor Magenta