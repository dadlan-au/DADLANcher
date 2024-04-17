function ShowWarcraft3Menu {
    Clear-Host
    Write-Host "Warcraft 3 Menu:`n"
    Write-Host "================================="
    Write-Host "1. Start Warcraft 3"
    Write-Host "2. Load Saved Game"
    Write-Host "3. Options"
    Write-Host "================================="
    Write-Host "X. Main Menu`n"

    $option = Read-Host "Type option:"
    switch ($option) {
        "1" { Start-Warcraft3 }
        "2" { Load-SavedGame }
        "3" { ShowOptions }
        "X" { ShowMainGameMenu }
        default {
            Write-Host "Invalid option. Please select again."
            ShowWarcraft3Menu
        }
    }
}

# Start the script by showing the Warcraft 3 menu
ShowWarcraft3Menu
