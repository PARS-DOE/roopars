# RooPARS One-Line Installer
# This script downloads and runs the main RooPARS installer

Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "   RooPARS One-Line Installer        " -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "Downloading RooPARS installer..." -ForegroundColor Green

# Download the main installer
$installerUrl = "https://raw.githubusercontent.com/PARS-DOE/roopars/main/install.ps1"
$tempFile = "install-roopars-temp.ps1"

try {
    Invoke-WebRequest -Uri $installerUrl -OutFile $tempFile
    
    # Run the installer
    Write-Host "Running RooPARS installer..." -ForegroundColor Green
    & ".\$tempFile"
    
    # Cleanup
    Remove-Item -Path $tempFile -Force
    
    Write-Host "One-line installation completed!" -ForegroundColor Green
}
catch {
    Write-Host "Error: Failed to download or run the installer." -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
}