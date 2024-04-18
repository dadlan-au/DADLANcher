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

$menu['main'] = @('Battlefield 1942','Battlefield 2','Warcraft 3','Unreal tournament 2004','Warcraft 3')

$menu['bf2'] = @('Start Battlefield 2','Launch DADLAN BF2 10.0.0.102','Configure Game Directory')
$menu['bf1942'] = @('Start Battlefield 1942','Launch DADLAN BF1942 10.0.0.102','Configure Game Directory')
$menu['cnc'] = @('Start CnC with no parameters','Host LAN Game','Join LAN Game','Join Internet Game','Configure Game Directory')
$menu['network'] = @('Check-Wireguard','Install-Wireguard')
$menu['quake'] = @('Start Quake 2','Start Quake 3','Launch DADLAN Quake 2','Launch DADLAN Quake 3','Configure Game Directory')
$menu['ut2004'] = @('Start Unreal Tournament','Configure Game Directory')
$menu['warcraft3'] = @('Start Warcraft 3','Start Warcraft 3 Frozen Throne','Launch Lancraft','Configure Game Directory')
#====================================================================================================================

#Menu-MainGame
$select_menu = "main"
do {
    Menu-Show -MenuName $select_menu
    $option = Read-Host "Choose an option"
    switch ($option) {
        "0" { $menu[$MenuName][0] }
        "1" { $menu[$MenuName][1] }
        "2" { $menu[$MenuName][2] }
        "3" { $menu[$MenuName][3] }
        "4" { $menu[$MenuName][4] }
        "5" { $menu[$MenuName][5] }
        "6" { $menu[$MenuName][6] }
        "7" { $menu[$MenuName][7] }
        "8" { $menu[$MenuName][8] }
        "9" { $menu[$MenuName][9] }
        "X" { Write-Host Exit }
        default { 
            Write-Host "Invalid option. Please select again."
            Menu-Show -MenuName $MenuName
        }
    }
} until ($option -eq 'X') 