echo off
CLS
color 0A

:begin
set wgactive=0
set op=
set wgname=1
set file=
set cncrenip=
set cncrenname=
cd "C:\Users\%USERNAME%\Desktop\DADLAN"
type ASCIILOGO.txt
echo.
echo Testing Wireguard Connection:
ping -n 1 10.0.0.102 | find "TTL=" >nul

if errorlevel 1 (
    goto WGactivate
) else (
    goto mnu
)
    
:WGactivate 

echo.
echo Wireguard is not active. Press 1 to activate Wireguard or 2 to proceed to menu.
set wgactive=0
echo.
set /p op=Type option:
if "%op%"=="1" goto op1
if "%op%"=="2" goto op2
	
:op1
goto WG

:op2
goto MainMenu

:mnu
echo.
echo Wireguard is active. Press any key to load the menu.
set wgactive=0
Pause
goto MainMenu


:WG
echo.
echo select a file to activate Wireguard
echo.
Pause

cls
type ASCIILOGO.txt
echo.
set dialog="about:<input type=file id=FILE><script>FILE.click();new ActiveXObject
set dialog=%dialog%('Scripting.FileSystemObject').GetStandardStream(1).WriteLine(FILE.value);
set dialog=%dialog%close();resizeTo(0,0);</script>"
for /f "tokens=* delims=" %%p in ('mshta.exe %dialog%') do set "file=%%p"
echo selected  file is : "%file%"
for %%a in ("%file%") do set "wgname=%%~na"
echo.
pause

cls
"C:\Program Files\WireGuard\wireguard.exe" /installtunnelservice "%file%"
type ASCIILOGO.txt
echo.
echo press any key to test wireguard configuration
echo.
pause

CLS
type ASCIILOGO.txt
echo.
echo testing wireguard connection:
echo.
::Add timeout here for about 5 seconds to allow Ping to work without waiting at above step.
ping -n 1 10.0.0.102 | find "TTL=" >nul
if errorlevel 1 (
    echo Wireguard is not active. Try re-launch as admin OR get a new WG config file from the helpdesk in Discord.
	set wgactive=0
) else (
    echo Wireguard is active
	set wgactive=1
)
echo.
pause

goto MainMenu

:MainMenu
CLS
type ASCIILOGO.txt
echo.
echo.
echo.
echo Main Menu:
echo =============
echo.
ECHO 1.Games Menu
ECHO 2.Wireguard Menu
ECHO 3.Discord
ECHO 4.Exit
ECHO 5.Restart DadLANcher
echo.
set /p op=Type option:
if "%op%"=="1" goto op1
if "%op%"=="2" goto op2
if "%op%"=="3" goto op3
if "%op%"=="4" goto op4
if "%op%"=="5" goto op5
echo.
echo Please Pick an option:

:op1
echo Games Menu Loading...
pause
CLS
goto GameMenu

:op2
echo Wireguard Menu Loading...
pause
CLS
goto WGMenu

:op3
echo Starting Discord...
pause
CLS
goto MainMenu

:op4
::Checks if WG is connected. If no will exit normally. If yes, but config file not selected via DadLANcher then will advise and exit. If yes and config selected, will disconnect WG
ping -n 1 10.0.0.102 | find "TTL=" >nul
if errorlevel 1 (
    echo Exiting DadLANcher.
	Pause
	@exit
) else (
if %wgname%==1 (
	echo Wireguard config file is not stored. Please disconnect wireguard manually.
	Pause
	@exit
)
	echo.
	echo Exiting DadLANcher...
	"C:\Program Files\WireGuard\wireguard.exe" /uninstalltunnelservice %wgname%
	pause
	@exit
)

:op5
echo Restarting DadLANcher...
pause
CLS
goto begin

:GameMenu
CLS
type ASCIILOGO.txt
echo.
echo.
echo.
echo Games Menu:
echo =============
echo.
ECHO 1.Battlefield 1942
ECHO 2.Battfield 2
ECHO 3.Warcraft 3
ECHO 4.Unreal Tournament 2004
ECHO 5.Quake 3
ECHO 6.Command ^& Conquer Renegade: A ^Path Beyond
ECHO 7.Main Menu

echo.
set /p op=Type option:
if "%op%"=="1" goto op1
if "%op%"=="2" goto op2
if "%op%"=="3" goto op3
if "%op%"=="4" goto op4
if "%op%"=="5" goto op5
if "%op%"=="6" goto op6
if "%op%"=="7" goto op7
echo Please Pick an option:
goto Menu2

:op1
echo Starting Battlefield 1942
::"C:\Program Files (x86)\EA GAMES\Battlefield 1942\BF19421.exe"
pause
CLS
goto GameMenu

:op2
echo Starting Battlefield 2
::"C:\Program Files (x86)\BF2Hub Client\bf2hub.exe" Launch mod: mods/bf2
CLS
goto GameMenu

:op3
echo Starting Warcraft 3
::"C:\Program Files (x86)\Warcraft III\Frozen Throne.exe"
CLS
goto GameMenu

:op4
echo Starting Unreal Tournament 2004
::"C:\GOG Games\Unreal Tournament 2004\System\UT2004.exe"
CLS
goto GameMenu

:op5
echo Quake 3
::"C:\Users\%USERNAME%\Downloads\Games\Quake3\Quake3\quake3e-vulkan.x64.exe"
CLS
goto GameMenu

:op6
echo Loading Command ^& Conquer Renegade: A Path Beyond Menu
pause
CLS
goto CncRenMenu

:op7
echo.
echo Main Menu Loading...
pause
CLS
goto MainMenu

:WGMenu
CLS
type ASCIILOGO.txt
echo.
echo.
echo.
echo Games Menu:
echo =============
echo.
ECHO 1.Activate Wireguard
ECHO 2.Deactivate Wireguard
ECHO 3.Test Wireguard
ECHO 4.Main Menu

echo.
set /p op=Type option:
if "%op%"=="1" goto op1
if "%op%"=="2" goto op2
if "%op%"=="3" goto op3
if "%op%"=="4" goto op4
echo Please Pick an option:
goto WGMenu

:op1
echo.
ping -n 1 10.0.0.102 | find "TTL=" >nul
if errorlevel 1 (
    echo Wireguard is not active.
	set wgactive=0
	pause
	goto activate
) else (
    echo Wireguard is active
	set wgactive=1
	pause
	goto WGMenu
)


:activate
echo.
echo select a file to activate Wireguard
echo.
Pause

cls
type ASCIILOGO.txt
echo.
set dialog="about:<input type=file id=FILE><script>FILE.click();new ActiveXObject
set dialog=%dialog%('Scripting.FileSystemObject').GetStandardStream(1).WriteLine(FILE.value);
set dialog=%dialog%close();resizeTo(0,0);</script>"
for /f "tokens=* delims=" %%p in ('mshta.exe %dialog%') do set "file=%%p"
echo selected  file is : "%file%"
for %%a in ("%file%") do set "wgname=%%~na"
echo.
pause

cls
"C:\Program Files\WireGuard\wireguard.exe" /installtunnelservice "%file%"
type ASCIILOGO.txt
echo.
echo press any key to test wireguard configuration
echo.
pause

CLS
type ASCIILOGO.txt
echo.
echo testing wireguard connection:
echo.
ping -n 1 10.0.0.102 | find "TTL=" >nul
if errorlevel 1 (
    echo Wireguard is not active. Try re-launch as admin OR get a new WG config file from the helpdesk in Discord.
	set wgactive=0
) else (
    echo Wireguard is active
	set wgactive=1
)
echo.
pause

goto WGMenu
:op2
::Put in check if var is populated. If not ask to identify file then kill WG. Choice to close LANcher without killing WG?
if %wgactive% == 0 echo Wireguard config file is not stored. Please disconnect wireguard manually.
"C:\Program Files\WireGuard\wireguard.exe" /uninstalltunnelservice %wgname%
echo Wireguard has been deactivated
pause
CLS
goto WGMenu

:op3
echo.
ping -n 1 10.0.0.102 | find "TTL=" >nul
if errorlevel 1 (
    echo Wireguard not reachable
	set wgactive=0
) else (
    echo Wireguard is active
	set wgactive=1
)
pause
CLS
goto WGMenu

:op4
echo Main Menu Loading...
pause
CLS
goto MainMenu

:CncRenMenu
CLS
type ASCIILOGO.txt
echo.
echo.
echo.
echo Command ^& Conquer Renegade: A Path Beyond Menu:
echo =============
echo.
ECHO 1.Launch game with no parameters
ECHO 2.Host LAN game
ECHO 3.Join LAN game
ECHO 4.Join Internet game
ECHO 5.Games Settings
ECHO 6.Game Menu
ECHO 7.Main Menu

echo.
set /p op=Type option:
if "%op%"=="1" goto op1
if "%op%"=="2" goto op2
if "%op%"=="3" goto cncop3
if "%op%"=="4" goto op4
if "%op%"=="5" goto op5
if "%op%"=="6" goto op6
if "%op%"=="7" goto op7
echo Please Pick an option:
goto Menu2

:op1
echo Starting Command ^& Conquer Renegade: A Path Beyond
pause
echo.
::"C:\Program Files\W3D Hub\games\apb\release\game.exe"
echo Press any key to return to the echo Command ^& Conquer Renegade: A Path Beyond menu
pause
CLS
goto CncRenMenu

:op2
echo Starting LAN host mode
pause
echo.
::"C:\Program Files\W3D Hub\games\apb\release\game.exe"
echo Press any key to return to the echo Command ^& Conquer Renegade: A Path Beyond menu
pause
CLS
goto CncRenMenu

:cncop3
CLS
type ASCIILOGO.txt
echo.
echo.
echo.
echo Starting LAN join mode
pause
echo.
echo.
set cncrenip=
set cncrenname=
if [%cncrenip%]==[] goto cncrenip
goto cncrenname

:cncrenip
echo.
set /p cncrenip=Enter the IP address of the LAN host:
pause
echo.
if [%cncrenip%]==[] (
    echo No IP Entered. Please enter the IP address of the host.
	goto cncop3
	pause
) else (
    goto cncrenname
	pause
)
:cncrenname
echo.
set /p cncrenname=Enter your player nickname:
pause
echo.
if [%cncrenname%]==[] (
    echo No IP Entered. Please enter the IP address of the host.
	pause
) else (
    goto cncrenlanjoin
	pause
)

:cncrenlanjoin
echo.
echo -launcher ^+connect %cncrenip% ^+netplayername %cncrenname%
::"C:\Program Files\W3D Hub\games\apb\release\game.exe" -launcher ^+connect %cncrenip% ^+netplayername %cncrenname%
echo Press any key to return to the echo Command ^& Conquer Renegade: A Path Beyond menu

pause
CLS
goto CncRenMenu

:op4
echo Starting online game mode
pause
echo.
::"C:\Program Files\W3D Hub\games\apb\release\game.exe"
echo Press any key to return to the echo Command ^& Conquer Renegade: A Path Beyond menu
pause
CLS
goto CncRenMenu

:op5
echo Command ^& Conquer Renegade: A Path Beyond Settings
pause
echo.
::"C:\Program Files\W3D Hub\games\apb\release\game.exe"
echo Press any key to return to the Command ^& Conquer Renegade: A Path Beyond menu
pause
CLS
goto CncRenMenu

:op6
echo Game Menu Loading...
pause
CLS
goto GameMenu

:op7
echo Main Menu Loading...
pause
CLS
goto MainMenu
