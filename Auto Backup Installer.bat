@echo off
title Auto Backup Installer
:start
@echo off
cls
echo Welcome to the Auto Backup setup
pause
cls
echo Where do you want to install?
setlocal
set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Please choose a folder.',0,0).self.path""
for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "folder=%%I"
setlocal enabledelayedexpansion
endlocal
mkdir "%folder%\Auto-Backup-Program\"
cls
echo Program will be installed in %folder%\Auto-Backup-Program\
pause
cls
echo Do you want to create a shortcut in the current directory?
choice /n /m "(Y/N)" /c yn
if %ERRORLEVEL%==2 goto install
echo Set oWS = WScript.CreateObject("WScript.Shell") >> shortcut.vbs
echo sLinkFile = "%cd%\AutoBackup.lnk" >> shortcut.vbs
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> shortcut.vbs
echo oLink.TargetPath = "%folder%\auto-backup-program\autobackup.exe" >> shortcut.vbs
echo oLink.WorkingDirectory = "%folder%\Auto-Backup-Program\" >> shortcut.vbs
echo oLink.Save >> shortcut.vbs
cscript /nologo shortcut.vbs
del shortcut.vbs /q

:install
cls
echo Downloading. . .
echo.
echo This may take a while.
( echo open ftpp.ostentv.dk
  echo anonymous
  echo 
  echo cd autobackupprogram
  echo binary 
  echo lcd "%folder%"
  echo lcd Auto-Backup-Program
  echo mget *.*
  echo bye) > installer.xml
ftp -i -s:installer.xml >nul
del installer.xml
if not exist "%folder%\auto-backup-program\autobackup.exe" goto fail
cls
echo Installing. . .
mkdir "%appdata%\Microsoft\Windows\Start Menu\Programs\Auto-Backup-Program\"
echo Set oWS = WScript.CreateObject("WScript.Shell") >> startmenu.vbs
echo sLinkFile = "%appdata%\Microsoft\Windows\Start Menu\Programs\Auto-Backup-Program\AutoBackup.lnk" >> startmenu.vbs
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> startmenu.vbs
echo oLink.TargetPath = "%folder%\auto-backup-program\autobackup.exe" >> startmenu.vbs
echo oLink.WorkingDirectory = "%folder%\Auto-Backup-Program\" >> startmenu.vbs
echo oLink.Save >> startmenu.vbs
cscript /nologo startmenu.vbs
del startmenu.vbs /q
echo Set oWS = WScript.CreateObject("WScript.Shell") >> startmenu.vbs
echo sLinkFile = "%appdata%\Microsoft\Windows\Start Menu\Programs\Auto-Backup-Program\Uninstall.lnk" >> startmenu.vbs
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> startmenu.vbs
echo oLink.TargetPath = "%folder%\auto-backup-program\uninstall.exe" >> startmenu.vbs
echo oLink.WorkingDirectory = "%folder%\Auto-Backup-Program\" >> startmenu.vbs
echo oLink.Save >> startmenu.vbs
cscript /nologo startmenu.vbs
del startmenu.vbs /q
cls
echo All done.
pause
exit

:fail
cls
echo Something went wrong :/
echo Please try again later.
pause
goto install