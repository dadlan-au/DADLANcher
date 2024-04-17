function ShowBattlefield2Menu {
    Clear-Host
    Write-Host "Battlefield 2 Menu:`n"
    Write-Host "================================="
    Write-Host "1. Start Battlefield 2"
    Write-Host "2. Load Saved Game"
    Write-Host "3. Options"
    Write-Host "================================="
    Write-Host "X. Main Menu`n"

    $option = Read-Host "Type option:"
    switch ($option) {
        "1" { Start-Battlefield2 }
        "2" { Load-SavedGame }
        "3" { ShowOptions }
        "X" { ShowMainGameMenu }
        default {
            Write-Host "Invalid option. Please select again."
            ShowBattlefield2Menu
        }
    }
}

# Start the script by showing the Battlefield 2 menu
ShowBattlefield2Menu
