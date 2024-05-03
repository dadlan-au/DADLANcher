# Name   : suppfunctions.ps1
# Author : MrCaffeen, JimmyCapps, TheScise
# Date   : 20/03/2024
# Note   : functions that will run the command scripts

#====================================================================================================================
# VARIOUS FUNCTIONS

# function Get-Menu -MenuName
# function Update-Resolution
# function Update-GameInstall -Game
# function Start-Game -Game
# function Update-Game -Game
# function installmsi
# function installexe
# function get-easyview -Milliseconds -Pace {Line|Character}
# function GlobalThermonuclearWar
# function ASCIIlogo
# function Get-Platform
# function Get-InstallApp -Application -Version
# function Test-Wireguard

#Get-Verb
#====================================================================================================================

function Get-Menu {
    param (
        [parameter(Mandatory=$true)][string]$MenuName
    )
    
    if (($menu[$MenuName].Count -gt 0) -and ($menu[$MenuName].Count -lt 11)) {
        $x = 0
        foreach ($menuItem in $menu[$MenuName]) {
            $menuoutput += "`t[ $x ] $menuItem`n"
            $x ++
        }
        if (!(Test-WireGuard)) { $menuoutput += "`n`t[ N ] WireGuard Network <=== Action Required to connect to network" }
        if ($select_menu -ne "main") { $menuoutput += "`n`t[ M ] Main Menu" }
        $menuoutput += "`n`t[ X ] Exit`n`n"
    }
    Clear-Host
    ASCIIlogo
    #Write-Host $menuoutput
    $menuoutput |get-easyview
}
#====================================================================================================================
function Update-Resolution {
    # Load the System.Windows.Forms assembly
    Add-Type -AssemblyName System.Windows.Forms

    # Get the primary screen resolution
    $primaryScreen = [System.Windows.Forms.Screen]::PrimaryScreen
    $global:width = $primaryScreen.Bounds.Width
    $global:height = $primaryScreen.Bounds.Height
}
#====================================================================================================================
function Update-GameInstall {
    param (
        [parameter(Mandatory=$true)][string]$Game
    )
    foreach ($path in $global:gameinstall[$Game]) {
        $x = 0        
        While ($x -lt $global:gameinstall[$Game].Count) {
            if (Test-Path $global:gameinstall[$Game][$x]) {
                $global:gamefile[$Game] = $global:gameinstall[$Game][$x]
                return
            } 
            $x ++
        }
        Write-Host "404 GameFiles Not found" 
        Start-Sleep 10
    }
}

#====================================================================================================================
function Start-Game {
    param (
        [parameter(Mandatory=$true)][string]$Game
    )
    # check game install if gamefiles exist
    Update-GameInstall -Game $Game
    $directory = [System.IO.Path]::GetDirectoryName($global:gamefile[$Game])
    Set-Location -Path $directory
    
    if ($global:gameconfig[$Game] -ne $null) {
        & $global:gamefile[$Game] $global:gameconfig[$Game]
        #Start-Process -FilePath $global:gamefile[$Game] -Wait -ArgumentList $Args
        #Invoke-Expression "& '$global:gamefile[$Game]' $global:gameconfig[$Game]"

        #$processStartInfo = New-Object System.Diagnostics.ProcessInfo
        #$processStartInfo.Filename = $global:gamefile[$Game]
        #$processStartInfo.Arguments = $global:gameconfig[$Game]
        #$process = [System.Diagnostics.Process]::Start($processStartInfo)
    } else {
        & $global:gamefile[$Game]
        #Start-Process -FilePath $global:gamefile[$Game] -Wait
        #Invoke-Expression "& '$global:gamefile[$Game]'"

        #$processStartInfo = New-Object System.Diagnostics.ProcessInfo
        #$processStartInfo.Filename = $global:gamefile[$Game]
        #$process = [System.Diagnostics.Process]::Start($processStartInfo)
    }
    Start-Sleep 10
}

#====================================================================================================================
function Update-Game {
    param (
        [parameter(Mandatory=$true)][string]$Game
    )
    Write-Host 'old gameconfig:' $global:gameconfig[$Game]

        $global:playername = Read-Host "Enter Player Name"
        $global:playerpass = Read-Host "Enter Player Pass for Battlefield"

    if ($Game = 'bf2') {
        $global:gameconfig[$Game] = "+playerName $global:playername +playerPassword $global:playerpass +fullscreen 1 +restart 1 +joinServer 10.0.0.102 +port 16567"
    } 
    if ($Game = 'bf1942') {
        $global:gameconfig[$Game] = "+playerName $global:playername +password $global:playerpass +restart 1 +joinServer 10.0.0.102:14567"
    }
    if ($Game = 'cnc') {
        $global:gameconfig[$Game] = ""
    }
    if ($Game = 'et') {
        Update-Resolution
        $configfile = etmain\etconfig.cfg
        $content = Get-Content -Path $configfile
        for ($i = 0, $i -lt $content.Count; $i++) {
            if ($content[$i] -like "seta name*") { 
                $newLine = 'seta name "{0}"' -f $global:playername
                $content[$i] = $newLine
            }
            if ($content[$i] -like "seta r_customheight*") { 
                $newLine = 'seta name "{0}"' -f $global:height
                $content[$i] = $newLine
            }
            if ($content[$i] -like "seta r_customwidth*") { 
                $newLine = 'seta name "{0}"' -f $global:width
                $content[$i] = $newLine
            }
        }
        $content |Set-Content $configfile
    }
    if ($Game = 'quake2') {
        #$global:gameconfig[$Game] = "+connect 10.0.0.102 +set cddir D:\install\data +set basedir C:\Quake2"
        #$global:gameconfig[$Game] = "+connect 10.0.0.102 +name $global:playername"
        Update-Resolution
        $configfile = etmain\etconfig.cfg
        $content = Get-Content -Path $configfile
        for ($i = 0, $i -lt $content.Count; $i++) {
            if ($content[$i] -like "seta name*") { 
                $newLine = 'seta name "{0}"' -f $global:playername
                $content[$i] = $newLine
            }
            if ($content[$i] -like "seta r_customheight*") { 
                $newLine = 'seta name "{0}"' -f $global:height
                $content[$i] = $newLine
            }
            if ($content[$i] -like "seta r_customwidth*") { 
                $newLine = 'seta name "{0}"' -f $global:width
                $content[$i] = $newLine
            }
        }
        $content |Set-Content $configfile
    }
    if ($Game = 'quake3') {
        # https://ioquake3.org/help/players-guide/
        # maybe set these in the configfile q3config.cfg
        # but look inside the working directory for this config file
        Update-Resolution
        $configfile = etmain\etconfig.cfg
        $content = Get-Content -Path $configfile
        for ($i = 0, $i -lt $content.Count; $i++) {
            if ($content[$i] -like "seta name*") { 
                $newLine = 'seta name "{0}"' -f $global:playername
                $content[$i] = $newLine
            }
            if ($content[$i] -like "seta r_customheight*") { 
                $newLine = 'seta name "{0}"' -f $global:height
                $content[$i] = $newLine
            }
            if ($content[$i] -like "seta r_customwidth*") { 
                $newLine = 'seta name "{0}"' -f $global:width
                $content[$i] = $newLine
            }
        }
        $content |Set-Content $configfile
        #Get-Content q3config.cfg
        # seta name "$global:playername"
        # seta com_maxfps "60"
        # seta max_rate "10000"
        # seta server1 "10.0.0.102"
        # seta r_mode "-1"
        # seta r_customheight "1080"
        # seta r_customwidth "1920"
        # seta r_fullscreen "0"
        # manual commands ?
        # /cl_renderer opengl2
        # /vid_restart
    }
    if ($Game = 'ut2004') {
        $global:gameconfig[$Game] = ''
    }
    if ($Game = 'warcraft3') {
        $global:gameconfig[$Game] = ''
    }
    if ($Game = 'warcraft3tft') {
        $global:gameconfig[$Game] = ''
    }


    Write-Host 'new gameconfig:' $global:gameconfig[$Game]
    Start-Sleep 5
}
#====================================================================================================================
function installexe {
    param (
        [parameter(Mandatory = $true)][string]$pname,
        [parameter(Mandatory=$true)][string]$purl,
        [string]$pargs
    )    
    Write-Host "Installing EXE"

    Set-Location $env:TEMP
    $filename = $pname + '.msi'

    # Download and install Powershell (dependency)
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-WebRequest -Uri $purl -OutFile $filename
    Start-Process $filename "/q" $pargs
    Remove-Item $filename
}

#====================================================================================================================
function installmsi {
    param (
        [parameter(Mandatory = $true)][string]$pname,
        [parameter(Mandatory=$true)][string]$purl,
        [string]$pargs
    )    
    Write-Host "Installing EXE"

    Set-Location $env:TEMP
    $filename = $pname + '.msi'

    # Download and install Powershell (dependency)
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-WebRequest -Uri $purl -OutFile $filename
    Start-Process msiexec.exe -Wait -ArgumentList "/i $filename /quiet"
    Remove-Item $filename
}
#====================================================================================================================
function get-easyview{

    param(
        [int]$Milliseconds= 10,
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
        if($_ -notmatch "^\s+$"){Start-Sleep -Milliseconds $Milliseconds}
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
    Write-Output "LOGON:`t DADLAN`n`n" |get-easyview
    ASCIIlogo
    Start-Sleep 5
    Clear-Host
    Write-Output "GREETINGS PROFESSOR FALKEN.`n" |get-easyview
    Start-Sleep 5
    Write-Output "Hello.`n`n" |get-easyview
    Start-Sleep 5
    Write-Output "HOW ARE YOU FEELING TODAY?`n" |get-easyview
    Start-Sleep 5
    Write-Output "I'm fine. How are you?`n`n" |get-easyview
    Start-Sleep 5
    Write-Output "EXCELLENT. IT'S BEEN A LONG TIME. CAN YOU EXPLAIN THE REMOVAL OF YOUR USER ACCOUNT ON 6/23/73?`n" |get-easyview
    Start-Sleep 5
    Write-Output "People sometimes make mistakes.`n`n" |get-easyview
    Start-Sleep 5
    Write-Output "YES THEY DO. SHALL WE PLAY A GAME?`n" |get-easyview
    Start-Sleep 5
    Write-Output "Love to. How about Global Thermonuclear War?`n`n" |get-easyview
    Start-Sleep 5
    Write-Output "WOULDN'T YOU PREFER A GOOD GAME OF CHESS?`n" |get-easyview
    Start-Sleep 5
    Write-Output "Later. Let's play Global Thermonuclear War.`n`n" |get-easyview
    Start-Sleep 10
    Write-Output "FINE.`n" |get-easyview
    Start-Sleep 10
    Clear-Host
    $WarGames['asciimap'] |get-easyview -Milliseconds 150 -Pace Line
    Write-Output "WHICH SIDE DO YOU WANT?" |get-easyview
    Write-Output "`n  1.  UNITED STATES" |get-easyview
    Write-Output "`n  2.  SOVIET UNION" |get-easyview
    Write-Output "`nPLEASE CHOSE ONE:" |get-easyview

    do {
        $option = Read-Host
        switch ($option) {
            "1" { Start-Sleep 5 }
            "2" { Start-Sleep 5 }
        }
    } until (($option -eq 1) -or ($option -eq 2))

    Clear-Host
    Write-Output "AWAITING FIRST STRIKE COMMAND`n`n" |get-easyview
    Start-Sleep 8
    Write-Output "" |get-easyview
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
$ASCIILOGO |get-easyview -Milliseconds 10 -Pace Line
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
function Test-Wireguard {
    param (
        [string]$info
    )
    $WireGuardApp = "C:\Program Files\WireGuard\wireguard.exe"
    $WireGuardInstalled = Get-InstalledApp -Application 'WireGuard' -Version '0.5.3'
    $WireGuardFile = Test-Path $WireGuardApp
    $WireGuardProcess = Get-Process -Name "wireguard" -ErrorAction SilentlyContinue
    $WireGuardInterface = Get-NetAdapter -IncludeHidden | Where-Object { $_.InterfaceDescription -like "*WireGuard Tunnel*" }
    $WireGuardConfigDir = "C:\DADLAN\wireguard_conf\"
    $pingResult1 = Test-Connection -ComputerName 10.0.0.102 -Count 1 -Quiet
    #$pingResult2 = Test-Connection -ComputerName 10.0.0.129 -Count 1 -Quiet
    #$pingResult3 = Test-Connection -ComputerName 10.20.30.100 -Count 1 -Quiet

    # Test Connection
    # if ($pingResult1 -or $pingResult2 -or $pingResult3) { 
    if ($pingResult1) { 
        if ($info) { Write-Host "[INFO] Wireguard Ok" }
        return $true 
    }

    # Check Wireguard
    if (-not $WireGuardProcess) {
        if ($WireGuardInstalled -and $WireGuardFile) { 
            # Check Management Services
            $wg_mgmt_services = Get-Service |where-object { $_.Name -like 'WireGuardManager' }
            if ($wg_mgmt_services.status -eq 'Running') { 
                if ($info) { Write-Host 'Service OK' }
                return $true
            }
            
            # Check Tunnel Up Down            
            $wg_services = Get-Service |where-object { $_.Name -like 'WireGuardTunnel*' }
            if ($wg_services.status -eq 'Running') { 
                if ($info) { Write-Host 'Service OK' }
                return $true 
            } else {
                if ($info) { Write-Host '[INFO] Starting Tunnel' }
                $WireGuardConfig = $WireGuardConfigDir + (Get-ChildItem "C:\DADLAN\wireguard_conf").Name
                Start-Process -FilePath 'C:\Program Files\WireGuard\wireguard.exe' -ArgumentList "/installtunnelservice $WireGuardConfig"
            }
            
            
        } else {
            # Call Install Wireguard
            if ($info) { Write-Host '[ERR] Please Reinstall Wireguard' }
            Start-Sleep -Seconds 10
            return $false
        }
    }
}