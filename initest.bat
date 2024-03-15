:Readall1
@echo off
echo read all values
for /f "tokens=1,2 delims==" %%a in (DADCFG.ini) do (
if %%a==WGConfigempty set WGConfigempty=%%b
if %%a==Othervalue1 set Othervalue1=%%b
if %%a==Othervalue2 set Othervalue2=%%b
if %%a==Othervalue3 set Othervalue3=%%b
if %%a==Othervalue4 set Othervalue4=%%b
if %%a==Othervalue5 set Othervalue5=%%b
if %%a==Othervalue6 set Othervalue6=%%b
if %%a==Othervalue7 set Othervalue7=%%b
)

echo %WGConfigempty%
echo %Othervalue1%
echo %Othervalue2%
echo %Othervalue3%
echo %Othervalue4%
echo %Othervalue5%
echo %Othervalue6%
echo %Othervalue7%


pause

goto write

:write

set /p WGConfigvalue=Type option:
type DADCFG.ini | find /v "WGConfigempty=" > DADCFG.tmp
copy DADCFG.tmp DADCFG.ini
echo WGConfigempty=%WGConfigvalue%>> DADCFG.ini
pause

:Readall2
echo read all updated values
for /f "tokens=1,2 delims==" %%a in (DADCFG.ini) do (
if %%a==WGConfigempty set WGConfigempty=%%b
if %%a==Othervalue1 set Othervalue1=%%b
if %%a==Othervalue2 set Othervalue2=%%b
if %%a==Othervalue3 set Othervalue3=%%b
if %%a==Othervalue4 set Othervalue4=%%b
if %%a==Othervalue5 set Othervalue5=%%b
if %%a==Othervalue6 set Othervalue6=%%b
if %%a==Othervalue7 set Othervalue7=%%b
)

echo %WGConfigempty%
echo %Othervalue1%
echo %Othervalue2%
echo %Othervalue3%
echo %Othervalue4%
echo %Othervalue5%
echo %Othervalue6%
echo %Othervalue7%
pause

:Readone
echo read one value
for /f "tokens=1,2 delims==" %%a in (DADCFG.ini) do (
if %%a==WGConfigempty set WGConfigempty=%%b
)

echo %WGConfigempty%
pause