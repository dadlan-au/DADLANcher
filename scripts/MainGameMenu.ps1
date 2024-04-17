# Function to show the main game menu
function ShowMainGameMenu {
    Clear-Host
    Write-Host "DadLAN Games Menu:`n"
    Write-Host "=================================`n"
    Write-Host "1. Launch Battlefield 1942"
    Write-Host "2. Launch Battlefield 2"
    Write-Host "3. Launch Warcraft 3"
    Write-Host "4. Launch Unreal Tournament 2004"
    Write-Host "5. Launch Quake 3"
    Write-Host "6. Launch Command & Conquer Renegade: A Path Beyond"
	Write-Host "`n=================================`n"
    Write-Host "9. Main Menu"
    Write-Host "X. Exit`n"

    $option = Read-Host "Choose an option"

    switch ($option) {
        "1" { .\Battlefield1942Menu.ps1 }
        "2" { .\Battlefield2Menu.ps1 }
        "3" { .\Warcraft3Menu.ps1 }
        "4" { .\UnrealTournament2004Menu.ps1 }
        "5" { .\Quake3Menu.ps1 }
        "6" { .\CnCMenu.ps1 }
        "9" { .\InitialLaunch.ps1 }
        "X" { Exit }
        default {
            Write-Host "Invalid option. Please select again."
            ShowMainGameMenu
        }
    }
}

# Start the script by showing the main game menu
ShowMainGameMenu