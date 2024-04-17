function ShowBattlefield1942Menu {
    Clear-Host
    Write-Host "Battlefield 1942 Menu:`n"
    Write-Host "================================="
    Write-Host "1. Start Battlefield 1942"
    Write-Host "2. Load Saved Game"
    Write-Host "3. Options"
    Write-Host "================================="
    Write-Host "X. Main Menu`n"

    $option = Read-Host "Type option:"
    switch ($option) {
        "1" { Start-Battlefield1942 }
        "2" { Load-SavedGame }
        "3" { ShowOptions }
        "X" { ShowMainGameMenu }
        default {
            Write-Host "Invalid option. Please select again."
            ShowBattlefield1942Menu
        }
    }
}

# Start the script by showing the Battlefield 1942 menu
ShowBattlefield1942Menu
