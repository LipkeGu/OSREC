@echo off
echo Cleaning up...
DISM /Online /Cleanup-Image /StartComponentCleanup /ResetBase
net users Administrator /ACTIVE:NO
echo Der Administrator ist jetzt Deaktiviert, sollte was schiefgehen, starten sie den abgesicherten modus!
echo um ein Benutzerkonto zu erstellen!!!
pause
C:\Windows\System32\Sysprep\Sysprep.exe /generalize /oobe /shutdown