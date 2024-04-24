# Name   : suppfunctions.ps1
# Author : MrCaffeen, JimmyCapps, TheScise
# Date   : 20/03/2024
# Note   : functions that will run the command scripts

#====================================================================================================================
# VARIOUS FUNCTIONS
# function Menu-Show
# function Launch-Game
# function installexe
# function installmsi
# function ASCIIlogo
# function Get-Platform
# function Get-InstallApp -Application -Version
# function Check-Wireguard

#====================================================================================================================
function Menu-Show {
    param (
        [parameter(Mandatory=$true)][string]$MenuName
    )
    
    if (($menu[$MenuName].Count -gt 0) -and ($menu[$MenuName].Count -lt 9)) {
        $x = 0
        foreach ($menuItem in $menu[$MenuName]) {
            $menuoutput += "`t[ $x ] $menuItem`n"
            $x ++
        }
        $menuoutput += "`n`t[ M ] Main Menu"
        $menuoutput += "`n`t[ X ] Exit`n`n"
    }
    Clear-Host
    ASCIIlogo
    #Write-Host $menuoutput
    $menuoutput |get-easyview
}

#====================================================================================================================
function Launch-Game {
    param (
        [parameter(Mandatory=$true)][string]$Game,
        [string]$Args
    )
    # check game install if gamefiles exist

    # Launch game -wait
}

#====================================================================================================================
function installexe {
    Write-Host "Installing EXE"
}
#====================================================================================================================
function installmsi {
    Write-Host "Installing MSI"
}
#====================================================================================================================
function get-easyview{

    param(
        [int]$Milliseconds= 60,
        [ValidateSet("Line","Character")] 
        [String]$Pace = "Character"
    )

    If($pace -eq "Character"){
        $text = [char[]]($input | Out-String)
        $parameters = @{NoNewline = $true}
    } Else {
        $text = ($input | out-string) -split "`r`n"
        $parameters = @{NoNewline = $false}
    }

    $text | ForEach-Object{
        Write-Host $_ @parameters
        if($_ -notmatch "^\s+$"){Sleep -Milliseconds $Milliseconds}
    }
}
#====================================================================================================================
function GlobalThermonuclearWar {
    # https://github.com/built1n/wargames/blob/master/MAP
    $WarGames = @{}
    $WarGames['asciimap'] = '
                                                                           .
   __________--^-^-\.             ____                             __----/^\.
|\/.                \__.      ___/   ||                        ___/       _/._-_    .
|                      \.    /.     /.                __    __/          /__/   \/^^\___-__.
|                       L-^-/.     /.                 \.\_--                               \.
|                                 /                  _/                                 _/\/.
|.                               |                 _/.                            __ __/
 \.                              /.               /                           ___/.//
  \__                           /                |                           /    \/.
     \________         __ _____.\.                \_.          ____--_   /\_ \    
              \__.    /  V.    \ \                  \__      _/.      \_/   //
                 \   /.         \/.                    \.  _/.             //
                  \_/.                                   \_/             

           UNITED STATES                                   SOVIET UNION

'
    
    Clear-Host
    echo "LOGON:`t DADLAN`n`n" |get-easyview
    ASCIIlogo
    sleep 5
    Clear-Host
    echo "GREETINGS PROFESSOR FALKEN.`n" |get-easyview
    sleep 6
    echo "Hello.`n`n" |get-easyview
    sleep 5
    echo "HOW ARE YOU FEELING TODAY?`n" |get-easyview
    sleep 8
    echo "I'm fine. How are you?`n`n" |get-easyview
    sleep 5
    echo "EXCELLENT. IT'S BEEN A LONG TIME. CAN YOU EXPLAIN THE REMOVAL OF YOUR USER ACCOUNT ON 6/23/73?`n" |get-easyview
    sleep 8
    echo "People sometimes make mistakes.`n`n" |get-easyview
    sleep 5
    echo "YES THEY DO. SHALL WE PLAY A GAME?`n" |get-easyview
    sleep 8
    echo "Love to. How about Global Thermonuclear War?`n`n" |get-easyview
    sleep 5
    echo "WOULDN'T YOU PREFER A GOOD GAME OF CHESS?`n" |get-easyview
    sleep 5
    echo "Later. Let's play Global Thermonuclear War.`n`n" |get-easyview
    sleep 10
    echo "FINE.`n" |get-easyview
    sleep 10
    Clear-Host
    $WarGames['asciimap'] |get-easyview -Milliseconds 150 -Pace Line
    echo "WHICH SIDE DO YOU WANT?" |get-easyview
    echo "`n  1.  UNITED STATES" |get-easyview
    echo "`n  2.  SOVIET UNION" |get-easyview
    echo "`nPLEASE CHOSE ONE:" |get-easyview

    do {
        $option = Read-Host
        switch ($option) {
            "1" { sleep 5 }
            "2" { sleep 5 }
        }
    } until (($option -eq 1) -or ($option -eq 2))

    Clear-Host
    echo "AWAITING FIRST STRIKE COMMAND`n`n" |get-easyview
    sleep 8
    echo "" |get-easyview
}

#====================================================================================================================
function ASCIIlogo {
    $ASCIILOGO = ' _________________________________________________________________________________________
 |                                   ##############                                       |
 |                                 ##   ########                                          |
 |                                 ##   ########                                          |
 |                                         ##                                             |
 |                                        ###                                             |
 |                                   ########                                             |
 |                                 ##   #####                                             |
 |                                 ##   #####                                             |
 |                                      #####                                             |
 |                                      #####   ########                                  |
 |                                      ###  #############                                |
 |                                      ##   ##############                               |
 |                                   ###   #####     ###                                  |
 |                                    #    #          #                                   |
 |                                                                                        |
 |        ##       #######           #####      #####            ##      #######          |
 |        ###     ########           #####      #####            ##      ########         |
 |     ######################     ###   ################      #####################       |
 |       #######  ###     ###             ######  ######        ####### ####    ####      |
 |   ##   #####   ###     ######           #####   #####   ###   #####   ##      #####    |
 |        #####   ###     ######        #####      #####         #####   ##      #####    |
 |        #####   ###     ######        #####      #####         #####   ##      #####    |
 |     ########   #####   ######     ###################      ########   #####   #####    |
 |        #####   ###     ######       #######    ######        ######   ###     #####    |
 |        #####   ###     ######        #####      #####         #####   ##      #####    |
 |        #####   ###     #####         #####      #####         #####   ##      #####    |
 |        ###########   #####        ########      ########      ##########   #####       |
 |      #####  ######  ###              ###          ###        ###   ###### ####         |
 |     ######   ##########              ##           ###      #####   ###########         |
 |                                                                                        |
 |                                      ##      #####                                     |
 |                                   ###################                                  |
 |                                   ###################                                  |
 |                                ###   #####      #####                                  |
 |                                      #####      #####                                  |
 |                                      #####      #####                                  |
 |                                   ########      #####                                  |
 |                                    #######      #####                                  |
 |                                      #####      #####                                  |
 |                                      #####      #####                                  |
 |                                   ########   ###########                               |
 |                                    #######    #########                                |
 |                                         ##        ###                                  |
 |________________________________________________________________________________________|'
#Write-Host $ASCIILOGO -BackgroundColor Black -ForegroundColor Green |get-easyview -Milliseconds 10 -Pace Character
$ASCIILOGO |get-easyview -Milliseconds 60 -Pace Line
}

#====================================================================================================================
function Get-Platform {
    return [System.Environment]::OSVersion.Platform

if ($IsWindows -or $IsLinux -or $IsMacOs) {
    switch (Get-PSPlatform) {
        'Win32NT' { 
            New-Variable -Option Constant -Name IsWindows -Value $True -ErrorAction SilentlyContinue 
            New-Variable -Option Constant -Name IsLinux  -Value $false -ErrorAction SilentlyContinue
            New-Variable -Option Constant -Name IsMacOs  -Value $false -ErrorAction SilentlyContinue
        }
        'Unix' {
            New-Variable -Option Constant -Name IsWindows -Value $False -ErrorAction SilentlyContinue
            New-Variable -Option Constant -Name IsLinux  -Value $True -ErrorAction SilentlyContinue
            New-Variable -Option Constant -Name IsMacOs  -Value $false -ErrorAction SilentlyContinue
        }
        Default { 
            New-Variable -Option Constant -Name IsWindows -Value $False -ErrorAction SilentlyContinue
            New-Variable -Option Constant -Name IsLinux  -Value $False -ErrorAction SilentlyContinue
            New-Variable -Option Constant -Name IsMacOs  -Value $false -ErrorAction SilentlyContinue
            Write-Host "OS Type Not Detected"
            exit 404 
        }
    }
}
}

#====================================================================================================================
function Get-InstalledApp() {
    param (
        [parameter(Mandatory=$true)][string]$Application,
        [version]$Version
    )
    
    $installedVersion = $null

    if ($Version) {
        $installedApp = Get-Package -ProviderName Programs -IncludeWindowsInstaller | Where-Object { $_.Name -like "*$Application*" -and $_.Version -eq $Version }
    } else {
        $installedApp = Get-Package -ProviderName Programs -IncludeWindowsInstaller | Where-Object { $_.Name -like "*$Application*" }
    }

    if ($installedApp) {
        $installedVersion = [version]$installedApp.Version
        $installedAppName = $installedApp.Name
    

        # Compare the installed version
        if ($installedVersion -eq $Version) {
            #Write-Output "$installedAppName $InstalledVersion is installed"
            return $true
        } else {
            #Write-output "$installedAppName $Version is NOT installed"
            return $false
        }
    }

}

#====================================================================================================================
function Check-Wireguard {
    $WireGuardApp = "C:\Program Files\WireGuard\wireguard.exe"
    $WireGuardInstalled = Get-InstalledApp -Application 'WireGuard' -Version '0.5.3'
    $WireGuardFile = Test-Path $WireGuardApp
    $WireGuardProcess = Get-Process -Name "wireguard" -ErrorAction SilentlyContinue
    $WireGuardInterface = Get-NetAdapter -IncludeHidden | Where-Object { $_.InterfaceDescription -like "*WireGuard Tunnel*" }
    $WireGuardConfigDir = "C:\DADLAN\wireguard_conf\"
    $pingResult1 = Test-Connection -ComputerName 10.0.0.102 -Count 1 -Quiet
    $pingResult2 = Test-Connection -ComputerName 10.0.0.129 -Count 1 -Quiet
    $pingResult3 = Test-Connection -ComputerName 10.20.30.100 -Count 1 -Quiet

    # Test Connection
    if ($pingResult1 -or $pingResult2 -or $pingResult3) { Write-Host "[INFO] Wireguard Ok"; return $true }

    # Check Wireguard
    if (-not $WireGuardProcess) {
        if ($WireGuardInstalled -and $WireGuardFile) { 
            # Check Management Services
            $wg_mgmt_services = Get-Service |where { $_.Name -like 'WireGuardManager' }
            if ($wg_mgmt_services.status -eq 'Running') { Write-Host 'Service OK'; return $true }
            
            # Check Tunnel Up Down            
            $wg_services = Get-Service |where { $_.Name -like 'WireGuardTunnel*' }
            if ($wg_services.status -eq 'Running') { 
                Write-Host 'Service OK'; return $true 
            } else {
                Write-Host '[INFO] Starting Tunnel'
                $WireGuardConfig = $WireGuardConfigDir + (Get-ChildItem "C:\DADLAN\wireguard_conf").Name
                Start-Process -FilePath 'C:\Program Files\WireGuard\wireguard.exe' -ArgumentList "/installtunnelservice $WireGuardConfig"
            }
            
            
        } else {
            # Call Install Wireguard
            Write-Host '[ERR] Please Reinstall Wireguard'
            sleep 10
        }
    }
}