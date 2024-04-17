function ShowCnCMenu {
    Clear-Host
    Write-Host "Command & Conquer Renegade: A Path Beyond Menu:`n"
    Write-Host "================================="
    Write-Host "1. Launch game with no parameters"
    Write-Host "2. Host LAN game"
    Write-Host "3. Join LAN game"
    Write-Host "4. Join Internet game"
    Write-Host "5. Game DIR Selector"
    Write-Host "================================="
    Write-Host "X. Main Menu`n"

    $option = Read-Host "Type option:"
    switch ($option) {
        "1" { Start-CncRenegadeNoParams }
        "2" { Start-CncRenegadeHostLAN }
        "3" { Start-CncRenegadeJoinLAN }
        "4" { Start-CncRenegadeJoinInternet }
        "5" { Select-CncRenegadeGameDir }
        "X" { ShowMainGameMenu }  # Go back to the main game menu
        default {
            Write-Host "Invalid option. Please select again."
            ShowCnCMenu
        }
    }
}

# Start the script by showing the Command & Conquer menu
ShowCnCMenu
