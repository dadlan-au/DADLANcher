function ShowQuake3Menu {
    Clear-Host
    Write-Host "Quake 3 Menu:`n"
    Write-Host "============="
    Write-Host "1. Start Quake 3"
    Write-Host "2. Load Saved Game"
    Write-Host "3. Options"
    Write-Host "================================="
    Write-Host "X. Main Menu`n"

    $option = Read-Host "Type option:"
    switch ($option) {
        "1" { Start-Quake3 }
        "2" { Load-SavedGame }
        "3" { ShowOptions }
        "X" { ShowMainGameMenu }
        default {
            Write-Host "Invalid option. Please select again."
            ShowQuake3Menu
        }
    }
}

# Start the script by showing the Quake 3 menu
ShowQuake3Menu
