function ShowUnrealTournament2004Menu {
    Clear-Host
    Write-Host "Unreal Tournament 2004 Menu:`n"
    Write-Host "================================="
    Write-Host "1. Start Unreal Tournament 2004"
    Write-Host "2. Load Saved Game"
    Write-Host "3. Options"
    Write-Host "================================="
    Write-Host "X. Main Menu`n"

    $option = Read-Host "Type option:"
    switch ($option) {
        "1" { Start-UnrealTournament2004 }
        "2" { Load-SavedGame }
        "3" { ShowOptions }
        "X" { ShowMainGameMenu }
        default {
            Write-Host "Invalid option. Please select again."
            ShowUnrealTournament2004Menu
        }
    }
}

# Start the script by showing the Unreal Tournament 2004 menu
ShowUnrealTournament2004Menu
