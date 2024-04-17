# This script configures WireGuard settings

# Set script variables
$script:wgInstallPath = "C:\Program Files\WireGuard\"
$script:wgProgramName = "wireguard.exe"
$script:wgCompletePath = $wgInstallPath + $wgProgramName
$script:wgDefaultConfigPath = "C:\Program Files\WireGuard\Data\Configurations"
$script:wgInstallCheck = $null
$script:wgConfigCheck = $null
$script:wgConfigFile = $null
$script:wgname = ""

# 
# C:\Program Files\WireGuard> .\wireguard.exe /uninstalltunnelservice 240225_thescise

function WG-ShowMenu {
    # Run checks
    WG-InstallCheck
    WG-ConfigCheck

    # Display WireGuard configuration options
    Clear-Host
    Write-Host "WireGuard Configuration`n"
    Write-Host "=================================`n"
    Write-Host "1. Install WireGuard"
    if ($wgInstallCheck) {
    Write-Host "2. Activate WireGuard"
    Write-Host "3. Deactivate WireGuard"
    }
    Write-Host "`n=================================`n"
    Write-Host "X. Main Menu`n"

    if (!$wgInstallCheck) {
        Write-Host "[NOTE] Wireguard installation has not been detected." -ForegroundColor Yellow
        Write-Host "After installation is completed additional options will be available.`n" -ForegroundColor Yellow
    }

    # Prompt user to choose an option
    $option = Read-Host "Choose an option"

    # Process user's choice
    switch ($option) {
        "2" {
            WG-Activate
        }
        "3" {
            WG-Stop
        }
        "1" {
            WG-Install
        }
        "X" {
            # Return to main menu
            .\InitialLaunch.ps1
        }

        default {
            # Handle invalid input
            Write-Host "Invalid option. Please choose again."
            Start-Sleep -Seconds 2
            WG-ShowMenu
        }
    }
}

# Check if WireGuard is installed
Function WG-InstallCheck {
    if (Test-Path $wgCompletePath) {
        $script:wgInstallCheck = $true
    } else {
        $script:wgInstallCheck = $false
    }
}

# Check for existing configurations
Function WG-ConfigCheck {
    if (Test-Path $script:wgDefaultConfigPath -ErrorAction SilentlyContinue) {
        $existingConfigs = Get-ChildItem -Path $script:wgDefaultConfigPath -File -ErrorAction SilentlyContinue
        if ($existingConfigs) {
            $script:wgConfigCheck = $true
        } else {
            $script:wgConfigCheck = $false
        }
    } else {
        $script:wgConfigCheck = $false
    }
}

function WG-Activate {
    $result = Test-Connection -ComputerName 10.0.0.102 -Count 1 -Quiet
    if ($result) {
        Clear-Host
        Write-Host "Activate WireGuard`n"
        Write-Host "=================================`n"
        Write-Host "WireGuard is already activated and connected."
        Start-Sleep -Seconds 2
        WG-ShowMenu
    } else {
        Clear-Host
        Write-Host "Activate WireGuard`n"
        Write-Host "=================================`n"
        Write-Host "Select configuration file."

        if (!$script:wgConfigFile) {
            $selectedFile = Get-ConfigFile
            if (-not $selectedFile) {
                Write-Host "No file selected. Returning to the main menu."
                Start-Sleep -Seconds 2
                WG-ShowMenu
                return
            }
            $script:wgConfigFile = $selectedFile
        }
        
        Write-Host "File: '$($script:wgConfigFile)' selected."
        Write-Host ""
        Write-Host "1.  Activate WireGuard"
        Write-Host "2.  Cancel"
        $op = Read-Host "Choose an option"
        switch ($op) {
            "1" { WG-Start }
            "2" { WG-ShowMenu }
            default { 
                # Handle invalid input
                Write-Host "Invalid option. Please choose again."
                Start-Sleep -Seconds 2
                WG-Activate
            }
        }
        WG-ShowMenu
    }
}

# Function to start WireGuard
function WG-Start {
    Clear-Host
    Write-Host "WireGuard Configuration`n"
    Write-Host "=================================`n"
    Write-Host "Selected file is: $($script:wgConfigFile)"
    Write-Host ""
    Write-Host "Activating WireGuard..."

    #Start-Process -FilePath $script:wgCompletePath -ArgumentList "/installtunnelservice $script:wgConfigFile" -Wait
    & $script:wgCompletePath /installtunnelservice $script:wgConfigFile
    
    $result = Test-Connection -ComputerName 10.0.0.102 -Count 1 -Quiet
    if ($result) {
        Write-Host "`n[SUCCESS] WireGuard is active." -ForegroundColor Green
    } else {
        Write-Host "`n[FAILED] WireGuard is not active." -ForegroundColor Red
        Write-Host "`nPlease try the following:`n- Manually check WireGuard status.`n- Try re-launching the DadLANcher as admin.`n- Get a new WireGuard config file from the helpdesk in Discord."
        Pause
        WG-ShowMenu
    }
}

function WG-Stop {
    Clear-Host
    Write-Host "WireGuard Configuration`n"
    Write-Host "=================================`n"
    Write-Host "Disabling WireGuard..."

    if (!$script:wgConfigFile) {
        $selectedFile = Get-ConfigFile
        if (-not $selectedFile) {
            Write-Host "No file selected. Returning to the main menu."
            Start-Sleep -Seconds 2
            WG-ShowMenu
            return
        }
        $script:wgConfigFile = $selectedFile
    }

    $uninstallFileName = $selectedFile # CUT THE LAST CHARACTERS SO IT WORKS

    & $script:wgCompletePath /uninstalltunnelservice $($script:wgConfigFile)

    Write-Host "WireGuard deactivated."
    Start-Sleep -Seconds 2
    WG-ShowMenu
}


# Function to test WireGuard connection
function WG-Test {
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
        Write-Host "[FAILED] WireGuard is not active." -ForegroundColor Red
        Write-Host "`nPlease try the following:`n- Manually check WireGuard status.`n- Try re-launching the DadLANcher as admin.`n- Get a new WireGuard config file from the helpdesk in Discord."
    }
    Write-Host ""
    Write-Host "Press any key to return to the main menu."
    $null = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    WG-ShowMenu
}

# Function to silently install WireGuard
function WG-Install {
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
    if (Test-Path $script:wgInstallPath) {
        Write-Host "`n[SUCCESS] WireGuard installed successfully." -ForegroundColor Green
        Start-Sleep -Seconds 2
        
    } else {
        Write-Host "`n[FAIL] WireGuard installation failed." -ForegroundColor Red
        Write-Host "Please attempt manual installation.`n" -ForegroundColor Red
        pause
    }

    WG-InstallCheck
    WG-ShowMenu
}

function Get-ConfigFile {
    Add-Type -AssemblyName System.Windows.Forms

    $openFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $openFileDialog.InitialDirectory = "C:\Program Files"
    $openFileDialog.Filter = "Configuration Files (*.conf;*.idgaf)|*.conf;*.idgaf"
    $openFileDialog.Title = "Select WireGuard Configuration File"

    $dialogResult = $openFileDialog.ShowDialog()

    if ($dialogResult -eq "OK") {
        return $openFileDialog.FileName
    } else {
        return $null
    }
}

WG-ShowMenu