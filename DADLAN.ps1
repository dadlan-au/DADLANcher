# Name   : DADLAN.ps1
# Author : MrCaffeen, 
# Date   : 20/03/2024
# Note   : Conversion of Batch file for DADLAN/DADWAN use for application network and game controls

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
'C:\DADLAN\scripts\suppFunctions.ps1'

