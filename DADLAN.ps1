# Name   : DADLAN.ps1
# Author : MrCaffeen, JimmyCapps, TheScise, AusSTY
# Date   : 20/03/2024
# Note   : Conversion of Batch file for DADLAN/DADWAN use for application network and game controls

#====================================================================================================================
$Host.ui.rawui.backgroundcolor = "black"
$Host.ui.rawui.foregroundcolor = "green"

#====================================================================================================================
# LOAD SUPPLEMENTARY FUNCTIONS,
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

#====================================================================================================================
$menu = @{}
$menuaction = @{}

$menu['main'] = @('Battlefield 1942','Battlefield 2','Command and Conquer','Unreal tournament 2004','Warcraft 3','Chess','GLOBAL THERMONUCLEAR WAR')
$menuaction['main'] = @('$select_menu = "bf1942"','$select_menu = "bf2"','$select_menu = "cnc"','$select_menu = "ut2004"','$select_menu = "warcraft3"','Write-Host Chess is in the cupboard','GlobalThermonuclearWar')
$menu['bf2'] = @('Start Battlefield 2','Launch DADLAN BF2 10.0.0.102','Configure Game Directory')
$menuaction['bf2'] = @('')
$menu['bf1942'] = @('Start Battlefield 1942','Launch DADLAN BF1942 10.0.0.102','Configure Game Directory')
$menuaction['bf1942'] = @('')
$menu['cnc'] = @('Start CnC with no parameters','Host LAN Game','Join LAN Game','Join Internet Game','Configure Game Directory')
$menuaction['cnc'] = @('')
$menu['network'] = @('Check-Wireguard','Install-Wireguard')
$menuaction['network'] = @('')
$menu['quake'] = @('Start Quake 2','Start Quake 3','Launch DADLAN Quake 2','Launch DADLAN Quake 3','Configure Game Directory')
$menuaction['quake'] = @('')
$menu['ut2004'] = @('Start Unreal Tournament','Configure Game Directory')
$menuaction['ut2004'] = @('')
$menu['warcraft3'] = @('Start Warcraft 3','Start Warcraft 3 Frozen Throne','Launch Lancraft','Configure Game Directory')
$menuaction['warcraft3'] = @('')
#====================================================================================================================
$gameinstall = @{}

$gameinstall['bf2'] = @('C:\Program Files (x86)\EA GAMES\Battlefield 2\BF2.exe','D:\Program Files (x86)\EA GAMES\Battlefield 2\BF2.exe')
$gameinstall['bf1942'] = @('C:\Program Files (x86)\EA Games\Battlefield 1942\BF1942.exe','D:\Program Files (x86)\EA Games\Battlefield 1942\BF1942.exe')
$gameinstall['ut2004'] = @('C:\GOG Games\Unreal Tournament 2004\System\UT2004.exe','D:\GOG Games\Unreal Tournament 2004\System\UT2004.exe')
$gameinstall['warcraft3'] = @('C:\Program Files (x86)\Warcraft III\Warcraft III.exe','D:\Program Files (x86)\Warcraft III\Warcraft III.exe')
$gameinstall['warcraft3tft'] = @('C:\Program Files (x86)\Warcraft III\Frozen Throne.exe','D:\Program Files (x86)\Warcraft III\Frozen Throne.exe')
#====================================================================================================================

#Menu-MainGame
$select_menu = "main"
do {
    Menu-Show -MenuName $select_menu
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
        "M" { $select_menu = "main" }
        "X" { Write-Host Exit }
        default { 
            Write-Host "Invalid option. Please select again."
            Menu-Show -MenuName $MenuName
        }
    }
} until ($option -eq 'X') 