@echo off
cls
::find the Recovery Partition...
for %%a in (d,e,f,g,h,i,j,k,l,m,n,o,p,k,r,s,t,u,v,w,y,z) do if exist %%a:\Recovery.id set oempart=%%a:
if not exist "%oempart%\recovery.id" goto recovery_fail

echo Recovery tools: %oempart%\
label %oempart% RECOVERY
if not exist "%oempart%\Images" MD "%oempart%\Images"

diskpart /s %oempart%\cleanssd.txt
tools\imagex.exe /apply %oempart%\Images\system.wim 1 o:

::find the Windows Partition...
for %%b in (c,d,e,f,g,h,i,j,k,l,m,n,o,p,k,r,s,t,u,v,w,z) do if exist %%b:\Windows\Setup\State\State.ini set syspart=%%b:
if not exist %syspart%\Windows\Setup\State\State.ini goto sysdetect_fail

echo Windows Partition: %syspart%\
label %syspart% OS

if exist "%oempart%\Recovery\WindowsRE\winre.wim" call %oempart%\scripts\install_winre.bat
if exist %syspart%\Drivers call %oempart%\scripts\install_drivers.bat

goto done

:install_winre
call scripts\install_winre.bat
pause

:sysdetect_fail
echo The system partition worse not found!
pause

:recovery_fail
echo the recovery partition worse not found!
pause

:done