# This script configures WireGuard settings

# Set path variables
$wgInstallPath = "C:\Program Files\WireGuard"
$wgDefaultConfigPath = "C:\Program Files\WireGuard\Data\Configurations"
$wgInstallCheck = $false
$wgConfigCheck = $false
$wgConfigFile = ""
$wgname = ""

# Check if WireGuard is installed
if (-not (Test-Path $wgInstallPath)) {
    $wgInstallCheck = $true
} else {
    $wgInstallCheck = $false
}

# Check for existing configurations
if (Test-Path $wgDefaultConfigPath -ErrorAction SilentlyContinue) {
    $existingConfigs = Get-ChildItem -Path $wgDefaultConfigPath -File -ErrorAction SilentlyContinue
    if ($existingConfigs) {
        $wgConfigCheck = $true
    } else {
        $wgConfigCheck = $false
    }
} else {
    $wgConfigCheck = $false
}


# C:\Program Files\WireGuard> .\wireguard.exe /installtunnelservice "C:\Program Files\WireGuard\240225_thescise.conf"
# C:\Program Files\WireGuard> .\wireguard.exe /uninstalltunnelservice 240225_thescise

function ShowWireGuardMenu {
    # Display WireGuard configuration options
    Clear-Host
    Write-Host "WireGuard Configuration`n"
    Write-Host "=================================`n"
    Write-Host "1. Install WireGuard (Experimental)"
    if ($wgInstallCheck) {
    Write-Host "2. Activate WireGuard"
    Write-Host "3. Deactivate WireGuard"
    }
    Write-Host "`n=================================`n"
    Write-Host "X. Main Menu`n"

    # Prompt user to choose an option
    $option = Read-Host "Choose an option"

    # Process user's choice
    switch ($option) {
        "2" {
            Clear-Host
            Write-Host "WireGuard Configuration`n"
            Write-Host "=================================`n"
            Write-Host "Activating WireGuard..."
            Start-Sleep -Seconds 2
            Write-Host "WireGuard activated successfully."
            Start-Sleep -Seconds 2
            ShowWireGuardMenu
        }
        "3" {
            Clear-Host
            Write-Host "WireGuard Configuration`n"
            Write-Host "=================================`n"
            Write-Host "Deactivating WireGuard..."
            Start-Sleep -Seconds 2
            Write-Host "WireGuard deactivated successfully."
            Start-Sleep -Seconds 2
            ShowWireGuardMenu
        }
        "1" {
            Install-WireGuard
        }
        "X" {
            # Return to main menu
            .\InitialLaunch.ps1
        }

        default {
            # Handle invalid input
            Write-Host "Invalid option. Please choose again."
            Start-Sleep -Seconds 2
            ShowWireGuardMenu
        }
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
    <#Write-Host "Select a file to activate WireGuard"
    $file = Get-OpenFileDialog
    if (-not $file) {
        Write-Host "No file selected. Returning to the main menu."
        Show-Menu
        return
    }#>

    $wgname = [System.IO.Path]::GetFileNameWithoutExtension($file)
    Clear-Host
    Write-Host "WireGuard Configuration`n"
    Write-Host "=================================`n"

    Write-Host "Selected file is: $file"
    Write-Host ""
    Write-Host "Activating WireGuard..."
    Start-Process -FilePath "$wgInstallPath\wireguard.exe" -ArgumentList "/installtunnelservice", $file -Wait
    Write-Host "WireGuard activated successfully."
    Write-Host ""
    Write-Host "Press any key to test WireGuard configuration."
    $null = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    Test-WireGuard
}

# Function to test WireGuard connection
function Test-WireGuard {
    Clear-Host
    Write-Host "WireGuard Configuration Check`n"
    Write-Host "=================================`n"
    Write-Host "Testing WireGuard connection..."
    $result = Test-Connection -ComputerName 10.0.0.102 -Count 1 -Quiet
    if ($result) {
        Clear-Host
        Write-Host "WireGuard Configuration Check"
        Write-Host "=================================`n"
        Write-Host "[SUCCESS] WireGuard is active." -ForegroundColor Green
    } else {
        Clear-Host
        Write-Host "WireGuard Configuration Check"
        Write-Host "=================================`n"
        Write-Host "[FAIL] WireGuard is not active." -ForegroundColor Red
        Write-Host "`nPlease try the following:`n- Manually check WireGuard status.`n- Try re-launching the DadLANcher as admin.`n- Get a new WireGuard config file from the helpdesk in Discord."
    }
    Write-Host ""
    Write-Host "Press any key to return to the main menu."
    $null = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    Show-Menu
}

# Function to silently install WireGuard
function Install-WireGuard {
    $installerUrl = "https://download.wireguard.com/windows-client/wireguard-amd64-0.5.3.msi"
    $installerPath = "$env:TEMP\wireguard-amd64-0.5.3.msi"
    
    Clear-Host
    Write-Host "WireGuard Installation`n"
    Write-Host "=================================`n"
    Write-Host "Beginning WireGuard Instllation process..."
    # Download MSI from WireGuard site
    Write-Host "- Downloading WireGuard MSI..."
    Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath
    # Begin installation
    Write-Host "- Beginning installation process..."
    Start-Process -FilePath msiexec.exe -ArgumentList "/i $installerPath /quiet" -Wait -NoNewWindow
    # Remove installation files
    Remove-Item -Path $installerPath -Force

    # Check if installation was successful
    if (Test-Path $wgInstallPath) {
        Write-Host "[SUCCESS] WireGuard installed successfully." -ForegroundColor Green
        Start-Sleep -Seconds 2
        ShowWireGuardMenu
    } else {
        Write-Host "[FAIL] WireGuard installation failed." -ForegroundColor Red
        Write-Host "Please attempt manual installation.`n" -ForegroundColor Red
        pause
        ShowWireGuardMenu
    }
}

ShowWireGuardMenu