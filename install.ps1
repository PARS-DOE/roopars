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
        "system-prompt-orchestrator",
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

# Ask to update .gitignore
Write-Host "The .roo directory contains environment-specific variables and should" -ForegroundColor Yellow
Write-Host "typically not be committed to your repository. The memory-bank directory" -ForegroundColor Yellow
Write-Host "contains shared project context that's useful for collaboration." -ForegroundColor Yellow
Write-Host ""

# Default to 'y' if no input is provided
$updateGitignore = Read-Host "Would you like to update your .gitignore to exclude the .roo directory? [Y/n]"
if ([string]::IsNullOrWhiteSpace($updateGitignore)) {
    $updateGitignore = "y"
}

if ($updateGitignore -eq "y" -or $updateGitignore -eq "Y") {
    Write-Host "Updating .gitignore..." -ForegroundColor Green
    
    # Lines to add to .gitignore
    $gitignoreEntries = @(
        "# RooPARS - Environment-specific files",
        "/.roo/"
    )
    
    # Create or update .gitignore
    if (-not (Test-Path -Path ".gitignore")) {
        # Create new .gitignore with our entries
        $gitignoreEntries | Out-File -FilePath .gitignore -Encoding utf8
        Write-Host "Created .gitignore file."
    }
    else {
        # Check if the entries already exist before adding
        $content = Get-Content -Path .gitignore -Raw
        $needsUpdate = $false
        
        foreach ($entry in $gitignoreEntries) {
            if ($content -notmatch [regex]::Escape($entry)) {
                $needsUpdate = $true
                break
            }
        }
        
        if ($needsUpdate) {
            # Add a blank line for readability
            Add-Content -Path .gitignore -Value ""
            
            foreach ($entry in $gitignoreEntries) {
                if ($content -notmatch [regex]::Escape($entry)) {
                    Add-Content -Path .gitignore -Value $entry
                }
            }
            Write-Host "Updated .gitignore file."
        }
        else {
            Write-Host "The necessary entries are already in .gitignore."
        }
    }
}
else {
    Write-Host "Skipped updating .gitignore." -ForegroundColor Yellow
    Write-Host "Note: You might want to manually add '/.roo/' to your .gitignore file." -ForegroundColor Yellow
}

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