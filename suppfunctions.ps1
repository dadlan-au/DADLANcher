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
        $menuoutput += "`t[ X ] Exit"
    }
    Clear-Host
    ASCIIlogo
    #Write-Host $menuoutput
    $menuoutput |get-easyview -Milliseconds 60 -Pace Line
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
        [int]$Milliseconds= 50,
        [ValidateSet("Line","Character")] 
        [String] 
        $Pace = "Character"
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