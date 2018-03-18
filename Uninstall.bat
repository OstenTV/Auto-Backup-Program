@echo off
title Auto Backup - uninstall
cls
echo where is Auto Backup Program installed?
echo.
set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Please choose a folder.',0,0).self.path""
for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "folder=%%I"
choice /n /m "Are you sure you want to uninstall Auto Backup Program? (Y/N)" /c yn
if %ERRORLEVEL%==1 goto uninstall
if %ERRORLEVEL%==2 (
echo unistall aborted.
echo.
pause
exit
)

:uninstall
rmdir /s /q "%appdata%\Microsoft\Windows\Start Menu\Programs\Auto-Backup-Program"
rmdir /s /q "%folder%"
cls
echo All done.
echo.
pause
exit