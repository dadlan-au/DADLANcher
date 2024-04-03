# This script serves as the initial launch script for DadLANcher
$Host.UI.RawUI.WindowSize = New-Object System.Management.Automation.Host.Size(111, 36)
# Load ASCII logo
$asciilogo = Get-Content -Path "..\ASCIILOGO.txt"
# Set window size

<# TODO: 
- On load, check default wireguard directory (Set var in config file)
- If wireguard isnt in that folder, try find it and update variable.
- If not manually select and update variable.

- Do the same thing with config, check for previously imported - it should live in the wireguard folder.
- if not browse for it and update variable in config (after first import should be in the wireguard folder.).

- Add test info into menu prior to selecting configure.
#>

# Display welcome message and menu options
Clear-Host
$asciilogo
Write-Host "`nWelcome to DadLANcher!`n"
Write-Host "=================================`n"
Write-Host "1. Start Games"
Write-Host "2. Configure Wireguard"
Write-Host "`n=================================`n"
Write-Host "X. Exit`n"

# Prompt user to choose an option
$option = Read-Host "Choose an option"

# Process user's choice
switch ($option) {
    "1" {
        # Launch the main game menu script
        .\MainGameMenu.ps1
    }
    "2" {
        # Launch the Wireguard configuration script
        .\WireguardConfig.ps1
    }
    "3" {
        # Exit the script
        Write-Host "Exiting DadLANcher. Goodbye!"
        Start-Sleep -Seconds 2
        Exit
    }
    default {
        # Handle invalid input
        Write-Host "Invalid option. Please choose again."
        Start-Sleep -Seconds 2
        Clear-Host
        .\InitialLaunch.ps1 # Restart the script
    }
}
