# Name   : DADLAN.ps1
# Author : MrCaffeen, JimmyCapps, TheScise, AusSTY
# Date   : 20/03/2024
# Note   : Conversion of Batch file for DADLAN/DADWAN use for application network and game controls

#====================================================================================================================
$Host.ui.rawui.backgroundcolor = "black"
$Host.ui.rawui.foregroundcolor = "green"

#====================================================================================================================
# LOAD SUPPLEMENTARY FUNCTIONS,
#$PSScriptRoot

function Get-ScriptDirectory {
	$Invocation = (Get-Variable MyInvocation -Scope 1).Value
	Split-Path $Invocation.MyCommand.Path
	# TO TEST - See http://stackoverflow.com/questions/801967/how-can-i-find-the-source-path-of-an-executing-script
	# ABOVE MIGHT BE BETTER WRITTEN AS:
	# Split-Path $script:MyInvocation.MyCommand.Path
}
# dot source our supplementary functions file

$suppFunctions = Join-Path (Get-ScriptDirectory) suppfunctions.ps1

. $suppFunctions

Set-Location $PSScriptRoot

# MP3 Music to play for 60 seconds
function Start-Music {
    $wmp = New-Object -ComObject WMPlayer.OCX
    $wmp.URL = "c:\Users\MrCaffeen\Documents\GitHub\DADLANPS\8bit-music-for-game-68698.mp3"
    $wmp.controls.playitem($wmp.controls.currentItem)
    $wmp.controls.play()
    Start-Sleep -Seconds 5
    $wmp.controls.stop()
}
#====================================================================================================================
#Invoke-Command -scriptblock { Start-Music }

#====================================================================================================================
$global:download = @{}
$global:download['wireguard'] = "https://download.wireguard.com/windows-client/wireguard-installer.exe"
$global:download['powershell'] = "https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-x64.msi"
$global:download['zandronum'] = "https://zandronum.com/downloads/zandronum3.1-win32-installer.exe"

#====================================================================================================================
$global:gamefile = @{}
$global:gameconfig = @{}
$global:gameworkdir = @{}
$global:gameinstall = @{}
$global:gameserver = @{}
$global:gameinstall['bf2'] = @("C:\Program Files (x86)\EA GAMES\Battlefield 2\BF2.exe","D:\Program Files (x86)\EA GAMES\Battlefield 2\BF2.exe")
$global:gameconfig['bf2'] = "+fullscreen 1 +restart 1 +joinServer 10.0.0.102 +port 16567"
$global:gameserver['bf2'] = @('10.0.0.102','10.20.30.100')
#--------------------------------------------------------------------------------------------------------------------
$global:gameinstall['bf1942'] = @('C:\Program Files (x86)\EA Games\Battlefield 1942\BF1942.exe','D:\Program Files (x86)\EA Games\Battlefield 1942\BF1942.exe')
$global:gameconfig['bf1942'] = "+restart 1"
$global:gameserver['bf1942'] = @('10.0.0.102:14567','10.20.30.100:14567')
#--------------------------------------------------------------------------------------------------------------------
$global:gameinstall['cnc'] = @('')
#--------------------------------------------------------------------------------------------------------------------
$global:gameinstall['et'] = @('C:\DADLAN\games\Wolfenstein - Enemy Territory\et.exe','C:\Program Files (x86)\Steam\steamapps\common\Wolfenstein Enemy Territory\et.exe')
$global:gameserver['et'] = @('10.20.30.100:27970')
#--------------------------------------------------------------------------------------------------------------------
$global:gameinstall['quake2'] =@('C:\Program Files (x86)\Steam\steamapps\common\Quake 2\yquake2.exe','C:\Program Files (x86)\Steam\steamapps\common\Quake 2\quake2.exe','C:\Program Files (x86)\Steam\steamapps\common\Quake II RTX\quake2.exe','c:\DADLAN\games\Quake2\yquake2.exe','c:\DADLAN\games\Quake2\quake2.exe','C:\Program Files\ModifiableWindowsApps\Quake 2\quake2.exe','')
$global:gameserver['quake2'] = @('10.0.0.102:27910','10.20.30.100:27910')
#--------------------------------------------------------------------------------------------------------------------
$global:gameinstall['quake3'] =@('c:\Program Files\Quake III Arena\quake3.exe','c:\DADLAN\games\Quake3\quake3.exe','D:\SteamLibrary\steamapps\common\Quake 3 Arena','C:\Program Files (x86)\Steam\steamapps\common\Quake 3 Arena')
$global:gameserver['quake3'] = @('10.0.0.102:27960','10.20.30.100:27960')
#--------------------------------------------------------------------------------------------------------------------
$global:gameinstall['ut2004'] = @('C:\GOG Games\Unreal Tournament 2004\System\UT2004.exe','D:\GOG Games\Unreal Tournament 2004\System\UT2004.exe','C:\Program Files (x86)\Steam\steamapps\common\Unreal Tournament 2004\System\UT2004.exe')
#--------------------------------------------------------------------------------------------------------------------
$global:gameinstall['lancraft'] = @('C:\DADLAN\games\Lancraft\Lancraft\lancraft.exe')
$global:gameinstall['warcraft3'] = @('C:\Program Files (x86)\Warcraft III\Warcraft III.exe','D:\Program Files (x86)\Warcraft III\Warcraft III.exe')
$global:gameinstall['warcraft3tft'] = @('C:\Program Files (x86)\Warcraft III\Frozen Throne.exe','D:\Program Files (x86)\Warcraft III\Frozen Throne.exe')
#====================================================================================================================
$menu = @{}
$menuaction = @{}

$menu['main'] = @('Battlefield 1942','Battlefield 2','Command and Conquer','Wolfenstein: Enemy Territory','Quake II','Quake III','Unreal tournament 2004','Warcraft 3','Chess','GLOBAL THERMONUCLEAR WAR')
$menuaction['main'] = @('$select_menu = "bf1942"','$select_menu = "bf2"','$select_menu = "cnc"','$select_menu = "et"','$select_menu = "quake2"','$select_menu = "quake3"','$select_menu = "ut2004"','$select_menu = "warcraft3"','Write-Host Chess is in the cupboard','GlobalThermonuclearWar')
$menu['bf2'] = @('Start Battlefield 2','Launch DADLAN BF2 10.0.0.102','ConfigureSettings')
$menuaction['bf2'] = @('Start-Game -Game bf2','Start-Game -Game bf2','Update-Game -Game bf2')
$menu['bf1942'] = @('Start Battlefield 1942','Launch DADLAN BF1942 10.0.0.102','Configure Game Settings')
$menuaction['bf1942'] = @('Start-Game -Game bf1942',"Start-Game -Game bf1942",'Update-Game -Game bf1942')
$menu['cnc'] = @('Start CnC with no parameters','Host LAN Game','Join LAN Game','Join Internet Game','Configure Game Directory')
$menuaction['cnc'] = @('Start-Game -Game cnc','','','','Update-Game -Game cnc')
$menu['et'] = @('Start Wolfenstein: EnemyTerritory','Configure Game')
$menuaction['et'] = @('Start-Game -Game et','Update-Game -Game et')
$menu['network'] = @('Test-Wireguard','Install-Wireguard')
$menuaction['network'] = @("Test-Wireguard -info $true","Installexe -url $global:download['wireguard']")
$menu['quake2'] = @('Start Quake 2','Launch DADLAN Quake 2','Configure Game')
$menuaction['quake2'] = @('Start-Game -Game q2','Start-Game -Game q2','Update-Game -Game quake2')
$menu['quake3'] = @('Start Quake 3','Launch DADLAN Quake 3','Configure Game')
$menuaction['quake3'] = @('Start-Game -Game q3','Start-Game -Game q3','Update-Game -Game quake2')
$menu['ut2004'] = @('Start Unreal Tournament','Configure Game Directory')
$menuaction['ut2004'] = @('Start-Game -Game ut2004','Update-Game -Game ut2004')
$menu['warcraft3'] = @('Start Warcraft 3','Start Warcraft 3 Frozen Throne','Launch Lancraft')
$menuaction['warcraft3'] = @('Start-Game -Game warcraft3','Start-Game -Game warcraft3tft','Start-Game -Game Lancraft')
#====================================================================================================================

#$player = Start-Music

#Menu-MainGame
$select_menu = "main"
do {
    Get-Menu -MenuName $select_menu
    $option = Read-Host "Choose an option"
    switch ($option) {
        "0" { Invoke-Expression $menuaction[$select_menu][0] }
        "1" { Invoke-Expression $menuaction[$select_menu][1] }
        "2" { Invoke-Expression $menuaction[$select_menu][2] }
        "3" { Invoke-Expression $menuaction[$select_menu][3] }
        "4" { Invoke-Expression $menuaction[$select_menu][4] }
        "5" { Invoke-Expression $menuaction[$select_menu][5] }
        "6" { Invoke-Expression $menuaction[$select_menu][6] }
        "7" { Invoke-Expression $menuaction[$select_menu][7] }
        "8" { Invoke-Expression $menuaction[$select_menu][8] }
        "9" { Invoke-Expression $menuaction[$select_menu][9] }
        "N" { $select_menu = "network" }
        "M" { $select_menu = "main" }
        "X" { Write-Host Exit }
        default { 
            Write-Host "Invalid option. Please select again."
            Menu-Show -MenuName $MenuName
        }
    }
} until ($option -eq 'X') 