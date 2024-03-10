echo off
CLS
color 0A


:begin
cd "C:\Users\JamesCapplis\Desktop\DADLAN"
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
echo.
set /p op=Type option:
if "%op%"=="1" goto op1
if "%op%"=="2" goto op2
	
:op1
goto WG

:op2
goto Menu1

:mnu
echo.
echo Wireguard is active. Press any key to load the menu.
Pause
goto Menu1





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
ping -n 1 10.0.0.102 | find "TTL=" >nul
if errorlevel 1 (
    echo Wireguard is not active. Try re-launch as admin OR get a new WG config file from the helpdesk in Discord.
) else (
    echo Wireguard is active
)
echo.
pause

goto Menu1



:Menu1
CLS
type ASCIILOGO.txt
echo.
echo.
echo.
echo Select a game:
echo =============
echo.
ECHO 1.Battlefield 1942
ECHO 2.Battfield 2
ECHO 3.Warcraft 3
ECHO 4.Unreal Tournament 2004
ECHO 5.Quake 3
ECHO 6.exit
ECHO 7.test wireguard
ECHO 8.Activate wireguard
ECHO 9.Sub Menu
echo.
set /p op=Type option:
if "%op%"=="1" goto op1
if "%op%"=="2" goto op2
if "%op%"=="3" goto op3
if "%op%"=="4" goto op4
if "%op%"=="5" goto op5
if "%op%"=="6" goto op6
if "%op%"=="7" goto op7
if "%op%"=="8" goto op8
if "%op%"=="9" goto op9
echo.
echo Please Pick an option:



:op1
echo Starting Battlefield 1942
"C:\Program Files (x86)\EA GAMES\Battlefield 1942\BF19421.exe"
pause
CLS
goto Menu1

:op2
echo Starting Battlefield 2
"C:\Program Files (x86)\BF2Hub Client\bf2hub.exe" Launch mod: mods/bf2
CLS
goto Menu1

:op3
echo Starting Warcraft 3
"C:\Program Files (x86)\Warcraft III\Frozen Throne.exe"
CLS
goto Menu1

:op4
echo Starting Unreal Tournament 2004
"C:\GOG Games\Unreal Tournament 2004\System\UT2004.exe"
CLS
goto Menu1

:op5
echo Quake 3
"C:\Users\JamesCapplis\Downloads\Games\Quake3\Quake3\quake3e-vulkan.x64.exe"
CLS
goto Menu1

:op6
"C:\Program Files\WireGuard\wireguard.exe" /uninstalltunnelservice %wgname%
@exit


:op7
echo.
ping -n 1 10.0.0.102 | find "TTL=" >nul
if errorlevel 1 (
    echo Wireguard not reachable
) else (
    echo Wireguard is active
)
pause
CLS
goto Menu

:op8
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
) else (
    echo Wireguard is active
)
echo.
pause

goto Menu1

:op9
CLS
goto Menu2

:Menu2
CLS
type ASCIILOGO.txt
echo.
echo.
echo.
echo Menu2:
echo =============
echo.
ECHO 1.Back

echo.
set /p op=Type option:
if "%op%"=="1" goto op1
echo Please Pick an option:
goto Menu2


:op1
echo.
echo Test menu
pause
CLS
goto Menu1