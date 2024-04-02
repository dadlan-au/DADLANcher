# This script configures WireGuard settings

# Set path variables
$wireguard_install_path = "C:\Program Files\WireGuard"
$wg_config_file = "C:\path\to\your\config.conf"
$wgname = ""

# Display WireGuard configuration options
Clear-Host
Write-Host "WireGuard Configuration"

Write-Host "================================="
Write-Host "1. Activate WireGuard"
Write-Host "2. Deactivate WireGuard"
Write-Host "3. Return to Main Menu"

Write-Host "`nWireGuard Configuration"
Write-Host "================================="



# Prompt user to choose an option
$option = Read-Host "Choose an option:"

# Process user's choice
switch ($option) {
    "1" {
        Write-Host "Activating WireGuard..."
        Start-Sleep -Seconds 2
        Write-Host "WireGuard activated successfully."
        Start-Sleep -Seconds 2
        Clear-Host
        .\InitialLaunch.ps1 # Return to the initial launch menu
    }
    "2" {
        Write-Host "Deactivating WireGuard..."
        Start-Sleep -Seconds 2
        Write-Host "WireGuard deactivated successfully."
        Start-Sleep -Seconds 2
        Clear-Host
        .\InitialLaunch.ps1 # Return to the initial launch menu
    }
    "3" {
        # Return to main menu
        Clear-Host
        .\InitialLaunch.ps1
    }
    default {
        # Handle invalid input
        Write-Host "Invalid option. Please choose again."
        Start-Sleep -Seconds 2
        Clear-Host
        .\WireGuardConfig.ps1 # Restart the script
    }
}

function Activate-WireGuard {
    Clear-Host
    Write-Host "WireGuard is not active."
    Write-Host ""
    Write-Host "1 - Activate WireGuard"
    Write-Host "2 - Proceed to Menu"
    $op = Read-Host "Type option"
    switch ($op) {
        "1" { Start-WireGuard }
        "2" { Show-Menu }
        Default { Write-Host "Invalid option. Please choose 1 or 2." }
    }
}

# Function to start WireGuard
function Start-WireGuard {
    Clear-Host
    Write-Host "Select a file to activate WireGuard"
    $file = Get-OpenFileDialog
    if (-not $file) {
        Write-Host "No file selected. Returning to the main menu."
        Show-Menu
        return
    }

    $wgname = [System.IO.Path]::GetFileNameWithoutExtension($file)
    Clear-Host
    Write-Host "WireGuard Configuration"
    Write-Host "=======================`n"

    Write-Host "Selected file is: $file"
    Write-Host ""
    Write-Host "Activating WireGuard..."
    Start-Process -FilePath "$wireguard_install_path\wireguard.exe" -ArgumentList "/installtunnelservice", $file -Wait
    Write-Host "WireGuard activated successfully."
    Write-Host ""
    Write-Host "Press any key to test WireGuard configuration."
    $null = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    Test-WireGuard
}

# Function to test WireGuard connection
function Test-WireGuard {
    Clear-Host
    Write-Host "WireGuard Configuration Check"
    Write-Host "============================="
    Write-Host "Testing WireGuard connection..."
    $result = Test-Connection -ComputerName 10.0.0.102 -Count 1 -Quiet
    if ($result) {
        Clear-Host
        Write-Host "WireGuard Configuration Check"
        Write-Host "============================="
        Write-Host "[SUCCESS] WireGuard is active." -ForegroundColor Green
    } else {
        Clear-Host
        Write-Host "WireGuard Configuration Check"
        Write-Host "============================="
        Write-Host "[FAIL] WireGuard is not active." -ForegroundColor Red
        Write-Host "`nPlease try the following:`n- Manually check WireGuard status.`n- Try re-launching the DadLANcher as admin.`n- Get a new WireGuard config file from the helpdesk in Discord."
    }
    Write-Host ""
    Write-Host "Press any key to return to the main menu."
    $null = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    Show-Menu
}