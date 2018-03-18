:start
SETLOCAL EnableExtensions
verify on
@echo off
set /a easteregg=10
set /a backupnrloop=0
set /a currentdel=0
set /a renlow=0
set /a renhigh=1
set /a loadedconfig=0
set /a confirmdir=0
set /a shutdown=0
set /a shutdownwait=120
set /a doconsole=0
set /a backupnr=1
set /a configretryerrorcode=0
set /a manualupdate=0
set /a configconfirmed=0
set /a doftp=0
set /a passcorr=1
set installdir=%cd%
set latestversion=unknown
set latestversionrd=unknown
set currentversion=unknown
set currentversionrd=unknown
title Auto Backup
color 07
@echo off
if "%1%"=="debug" goto debug
if exist "Backup-config.txt" goto convertformat
if not exist "settings.bat" goto tutorial
cls
choice /t 5 /n /m "Press M now to access the menu, or S to skip." /c ms /d s
if %ERRORLEVEL%==1 goto menu
goto step1

:menu
set /a easteregg=10
title Auto Backup - Menu
cls
echo 1 = Run
echo 2 = Setup
echo 3 = Confirm save directory
echo 4 = Tutorial
echo 5 = Check for updates
echo 6 = Info
echo.
echo E = Exit
echo,
choice /n /m "Press a number" /c 123456xde
if %ERRORLEVEL%==1 (
if exist "settings.bat" (
goto step1
)
goto startfail
)
if %ERRORLEVEL%==2 (
set /a loadedconfig=1
goto step1
)
if %ERRORLEVEL%==3 goto confirmdir
if %ERRORLEVEL%==4 goto tutorial
if %ERRORLEVEL%==5 (
cls
echo I can't search for updates anymore :(
echo Check http://ostentv.dk/?view=downloads/abp for news.
echo.
pause
goto menu
)
if %ERRORLEVEL%==6 goto info
if %ERRORLEVEL%==7 goto easteregg
if %ERRORLEVEL%==8 goto debuge
if %ERRORLEVEL%==9 goto eoc

:info
title Auto Backup - Info
cls
echo Auto Backup Program by OstenTV
echo Website http://ostentv.dk
echo.
echo Current version
echo V.%currentversion%
echo %currentversionrd%
echo.
echo Latest version
echo V.%latestversion%
echo %latestversionrd%
echo.
pause
goto menu

:startfail
cls
echo Sorry you have to configure first.
timeout /t 2 /nobreak >nul
goto menu

:confirmdir
if not exist "settings.bat" goto confirmdirfail
title Auto Backup - Confirmation
set /a confirmdir=1
goto step1
:confirmdira
title Auto Backup - Confirmation
set /a confirmdir=0
echo This file serves as a auto confirmation for the Auto Backup Program. > %savetodir%\auto-confirm.txt
if not exist %savetodir%\auto-confirm.txt goto confirmdirfail
cls
echo Confirmation file successfully created.
timeout /t 2 /nobreak >nul
goto menu

:confirmdirfail
cls
echo Sorry you have to configure first
echo or the directory you enterd is invalid.
timeout /t 2 /nobreak >nul
goto menu

:tutorial
title Auto Backup - Tutorial
cls
choice /n /m "Skip tutorial? (Y/N): " /c yn
if %ERRORLEVEL%==1 goto menu
cls
echo To start of you are going to configure the Auto Backup program.
timeout /t 4 /nobreak >nul
echo The maximum amount of folders you can select is 5, do to limitations in batch.
timeout /t 4 /nobreak >nul
echo PLEASE DO NOT LEAVE ANY VALUES EMPTY
echo instead type 0
timeout /t 4 /nobreak >nul
echo Remember to use \ and not /.
timeout /t 4 /nobreak >nul
echo DON'T put a \ at the end of your directory.
echo.
choice /n /m "Do you wan't to configure now? Y/N: " /c yn
if %ERRORLEVEL%==1 (
set /a configoption=0
goto configchange
)
if %ERRORLEVEL%==2 goto menu

:configchange
cls
if %configoption%==1 goto configoption1
if %configoption%==2 goto configoption2
if %configoption%==3 goto configoption3
if %configoption%==4 goto configoption4
if %configoption%==5 goto configoption5
if %configoption%==6 goto configoption6
if %configoption%==7 goto configoption7
if %configoption%==8 goto configoption8
if %configoption%==9 goto configoption9
if %configoption%==10 goto configoption10
if %configoption%==11 goto configoption11
if %configoption%==12 goto configoption12
if %configoption%==13 goto configoption13
if %configoption%==14 goto configoption14
if %configoption%==15 goto configoption15
if %configoption%==16 goto configoption16
if not %configoption%==0 goto config
cls
:configoption1
set /p savetodir=Where should the backups be saved?: 
if %configoption% GEQ 1 goto config
:configoption2
set /p backupdir1=enter the 1st directory to save: 
if %configoption% GEQ 1 goto config
:configoption3
set /p backupdir2=enter the 2nd directory to save: 
if %configoption% GEQ 1 goto config
:configoption4
set /p backupdir3=enter the 3rd directory to save: 
if %configoption% GEQ 1 goto config
:configoption5
set /p backupdir4=enter the 4th directory to save: 
if %configoption% GEQ 1 goto config
:configoption6
set /p backupdir5=enter the 5th directory to save: 
if %configoption% GEQ 1 goto config
:configoption7
echo enter the name of the saved folder (NO DIRECTORIES)
echo Meaning what it should be called in the saved backup.
set /p fname1=Enter the 1st folder name: 
if %configoption% GEQ 1 goto config
:configoption8
set /p fname2=Enter the 2nd folder name: 
if %configoption% GEQ 1 goto config
:configoption9
set /p fname3=Enter the 3rd folder name: 
if %configoption% GEQ 1 goto config
:configoption10
set /p fname4=Enter the 4th folder name: 
if %configoption% GEQ 1 goto config
:configoption11
set /p fname5=Enter the 5th folder name: 
if %configoption% GEQ 1 goto config
:configoption12
set /p saveamount=how meney backups should be kept (min 1 max 512) if 1 the Auto Backup program will never delete old backups, instead it will overwrite if a given file is newer then the backup file: 
if %configoption% GEQ 1 goto config
:configoption13
set /p shutdown=should the computer shutdown after completion? (1/0): 
if %configoption% GEQ 1 goto config
:configoption14
set /p doconsole=Do you want console output? (1/0): 
if %configoption% GEQ 1 goto config
:configoption15
set /p doftp=Do you want to use FTP? (1/0): 
if %configoption% GEQ 1 goto config
:configoption16
set /p delafterftp=Do you want to delet local backups after FTP upload? (1/0): 
if %configoption% GEQ 1 goto config
goto config

:configconfirm
set /a configretryerrorcode=0
if "%savetodir%"=="" (
set /a configretryerrorcode=1
goto configretry
)
if "%backupdir1%"=="" (
set /a configretryerrorcode=2
goto configretry
)
if "%backupdir2%"=="" (
set /a configretryerrorcode=3
goto configretry
)
if "%backupdir3%"=="" (
set /a configretryerrorcode=4
goto configretry
)
if "%backupdir4%"=="" (
set /a configretryerrorcode=5
goto configretry
)
if "%backupdir5%"=="" (
set /a configretryerrorcode=6
goto configretry
)
if "%fname1%"=="" (
set /a configretryerrorcode=7
goto configretry
)
if "%fname2%"=="" (
set /a configretryerrorcode=8
goto configretry
)
if "%fname3%"=="" (
set /a configretryerrorcode=9
goto configretry
)
if "%fname4%"=="" (
set /a configretryerrorcode=10
goto configretry
)
if "%fname5%"=="" (
set /a configretryerrorcode=11
goto configretry
)
if "%saveamount%"=="" (
set /a configretryerrorcode=12
goto configretry
)
if not "%shutdown%"=="1" (
if not "%shutdown%"=="0" (
set /a configretryerrorcode=13
goto configretry
)
)
if not "%doconsole%"=="1" (
if not "%doconsole%"=="0" (
set /a configretryerrorcode=14
goto configretry
)
)
if not exist "%savetodir%\" (
set /a configretryerrorcode=15
goto configretry
)
if not "%backupdir1%"=="0" (
if not exist "%backupdir1%\" (
set /a configretryerrorcode=16
goto configretry
))
if not "%backupdir2%"=="0" (
if not exist "%backupdir2%\" (
set /a configretryerrorcode=17
goto configretry
))
if not "%backupdir3%"=="0" (
if not exist "%backupdir3%\" (
set /a configretryerrorcode=18
goto configretry
))
if not "%backupdir4%"=="0" (
if not exist "%backupdir4%\" (
set /a configretryerrorcode=19
goto configretry
))
if not "%backupdir5%"=="0" (
if not exist "%backupdir5%\" (
set /a configretryerrorcode=20
goto configretry
))
if %saveamount% GTR 512 (
set /a configretryerrorcode=21
goto configretry
)
if %saveamount% LSS 1 (
set /a configretryerrorcode=22
goto configretry
)
if not "%doftp%"=="1" (
if not "%doftp%"=="0" (
set /a configretryerrorcode=23
goto configretry
)
)
if not "%delafterftp%"=="1" (
if not "%delafterftp%"=="0" (
set /a configretryerrorcode=24
goto configretry
)
)
set /a configconfirmed=1
goto configsave

:configretry
cls
echo Something went wrong. Error code %configretryerrorcode%
echo.
echo Description:
if %configretryerrorcode%==0 echo No description was found.
if %configretryerrorcode%==1 echo You did not specify where to save the backups.
if %configretryerrorcode%==2 echo 1st backup directory was not specified.
if %configretryerrorcode%==3 echo 2nd backup directory was not specified.
if %configretryerrorcode%==4 echo 3rd backup directory was not specified.
if %configretryerrorcode%==5 echo 4th backup directory was not specified.
if %configretryerrorcode%==6 echo 5th backup directory was not specified.
if %configretryerrorcode%==7 echo Backup name 1 was not specified.
if %configretryerrorcode%==8 echo Backup name 2 was not specified.
if %configretryerrorcode%==9 echo Backup name 3 was not specified.
if %configretryerrorcode%==10 echo Backup name 4 was not specified.
if %configretryerrorcode%==11 echo Backup name 5 was not specified.
if %configretryerrorcode%==12 echo No amount of backups to keep was specified.
if %configretryerrorcode%==13 echo Shutdown value is not 1 or 0.
if %configretryerrorcode%==14 echo Console value is not 1 or 0.
if %configretryerrorcode%==15 echo The save directory you specified is invalid.
if %configretryerrorcode%==16 echo The 1st backup directory you specified is invalid.
if %configretryerrorcode%==17 echo The 2nd backup directory you specified is invalid.
if %configretryerrorcode%==18 echo The 3rd backup directory you specified is invalid.
if %configretryerrorcode%==19 echo The 4th backup directory you specified is invalid.
if %configretryerrorcode%==20 echo The 5th backup directory you specified is invalid.
if %configretryerrorcode%==21 echo The amount of backups to keep is higher then 512.
if %configretryerrorcode%==22 echo The amount of backups to keep is lower then 1.
if %configretryerrorcode%==23 echo Use FTP is not 1 or 0.
if %configretryerrorcode%==24 echo Delete after FTP is not 1 or 0.
echo. 
pause
goto config

:configsave
if %configconfirmed%==0 goto configconfirm
set /a configconfirmed=0
( echo set savetodir=%savetodir%
  echo set backupdir1=%backupdir1%
  echo set backupdir2=%backupdir2%
  echo set backupdir3=%backupdir3%
  echo set backupdir4=%backupdir4%
  echo set backupdir5=%backupdir5%
  echo set fname1=%fname1%
  echo set fname2=%fname2%
  echo set fname3=%fname3%
  echo set fname4=%fname4%
  echo set fname5=%fname5%
  echo set saveamount=%saveamount%
  echo set shutdown=%shutdown%
  echo set doconsole=%doconsole%
  echo set doftp=%doftp%
  echo set delafterftp=%delafterftp%) > settings.bat
cls
echo Config saved
timeout /t 2 /nobreak >nul
goto config

:config
set /a loadedconfig=0
title Auto Backup - Setup
cls
echo  1 = Save to dir = %savetodir%
echo  2 = Backup dir1 = %backupdir1%
echo  3 = Backup dir2 = %backupdir2%
echo  4 = Backup dir3 = %backupdir3%
echo  5 = Backup dir4 = %backupdir4%
echo  6 = Backup dir5 = %backupdir5%
echo  7 = File name1 = %fname1%
echo  8 = File name2 = %fname2%
echo  9 = File name3 = %fname3%
echo 10 = File name4 = %fname4%
echo 11 = File name5 = %fname5%
echo 12 = Nr of backups to keep = %saveamount%
echo 13 = Shutdown = %shutdown%
echo 14 = Console output = %doconsole%
echo 15 = Use FTP = %doftp%
echo 16 = Delete local files after FTP = %delafterftp%
echo.
echo A = Configure all values at once
echo F = Configure FTP
echo S = Save config
echo M = Back to menu
echo.
echo REMEMBER TO SAVE BEFORE EXITING!
echo.
set /p configoption=Type something: 
if %configoption%==s goto configsave
if %configoption%==m goto menu
if %configoption%==f (
set /a ftpconfloaded=1
goto ftp.conf.load
)
if %configoption%==a (
set /a configoption=0
goto configchange
)
goto configchange

:step1
title Auto Backup - Loading. . .
if exist "settings.bat" (
call settings.bat
)
if %loadedconfig%==1 (
set /a loadedconfig==0
goto config
)
if %confirmdir%==1 goto confirmdira
goto step2

:step2
if exist "%savetodir%\auto-confirm.txt" (
if not %saveamount%==1 goto step3.loop
)
if exist "%savetodir%\auto-confirm.txt" (
if %saveamount%==1 goto run.overwrite
)
title Auto Backup - ERROR
cls
echo ERROR
echo %savetodir%\auto-confirm.txt   not found
echo You can create the confirmation file in the menu.
echo.
choice /t 2 /n /m "Press M to access the menu" /c ms /d s
if %ERRORLEVEL%==1 goto menu
goto step2

:step3.loop
if not exist "%savetodir%\auto-confirm.txt" goto fail
title Auto Backup - Scanning
set /a backupnrloop=%backupnrloop%+1
if exist "%savetodir%\%backupnrloop%" goto step3.loop
if %saveamount% GEQ %backupnrloop% (
set /a backupnr=%backupnrloop%
goto run
)
goto step3.del

:step3.del
if not exist "%savetodir%\auto-confirm.txt" goto fail
cls
echo Deleting old backup. . .
title Auto Backup - Deleting
if exist "%savetodir%\%saveamount%" (
if exist "%savetodir%\1" (
rmdir "%savetodir%\1" /s /q
)
)
:step3.ren
if not exist "%savetodir%\auto-confirm.txt" goto fail
title Auto Backup - Renaming
set /a renlow=%renlow%+1
set /a renhigh=%renhigh%+1
rename "%savetodir%\%renhigh%" "%renlow%"
if %saveamount%==%renhigh% goto start
goto step3.ren

:run
if not exist "%savetodir%\auto-confirm.txt" goto fail
cls
echo Running Backup. . .
echo 1/5
title Auto Backup - Running 1/5
if not "%backupdir1%"==0 (
if %doconsole%==0 (
xcopy "%backupdir1%" "%savetodir%\%backupnr%\%fname1%\" /e >nul
)
if %doconsole%==1 (
xcopy "%backupdir1%" "%savetodir%\%backupnr%\%fname1%\" /e
)
)

:run.prog2
if not exist "%savetodir%\auto-confirm.txt" goto fail
cls
echo Running Backup. . .
echo 2/5
title Auto Backup - Running 2/5
if not "%backupdir2%"==0 (
if %doconsole%==0 (
xcopy "%backupdir2%" "%savetodir%\%backupnr%\%fname2%\" /e >nul
)
if %doconsole%==1 (
xcopy "%backupdir2%" "%savetodir%\%backupnr%\%fname2%\" /e
)
)

:run.prog3
if not exist "%savetodir%\auto-confirm.txt" goto fail
cls
echo Running Backup. . .
echo 3/5
title Auto Backup - Running 3/5
if not "%backupdir3%"==0 (
if %doconsole%==0 (
xcopy "%backupdir3%" "%savetodir%\%backupnr%\%fname3%\" /e >nul
)
if %doconsole%==1 (
xcopy "%backupdir3%" "%savetodir%\%backupnr%\%fname3%\" /e
)
)

:run.prog4
if not exist "%savetodir%\auto-confirm.txt" goto fail
cls
echo Running Backup. . .
echo 4/5
title Auto Backup - Running 4/5
if not "%backupdir4%"==0 (
if %doconsole%==0 (
xcopy "%backupdir4%" "%savetodir%\%backupnr%\%fname4%\" /e >nul
)
if %doconsole%==1 (
xcopy "%backupdir4%" "%savetodir%\%backupnr%\%fname4%\" /e
)
)

:run.prog5
if not exist "%savetodir%\auto-confirm.txt" goto fail
cls
echo Running Backup. . .
echo 5/5
title Auto Backup - Running 5/5
if not "%backupdir5%"==0 (
if %doconsole%==0 (
xcopy "%backupdir5%" "%savetodir%\%backupnr%\%fname5%\" /e >nul
)
if %doconsole%==1 (
xcopy "%backupdir5%" "%savetodir%\%backupnr%\%fname5%\" /e
)
)
if %doftp%==1 goto ftp.conf.load
goto completed

:run.overwrite
if not exist "%savetodir%\auto-confirm.txt" goto fail
cls
echo Running Backup. . .
echo 1/5
title Auto Backup - Running 1/5
if not "%backupdir1%"==0 (
if %doconsole%==0 (
xcopy "%backupdir1%" "%savetodir%\%backupnr%\%fname1%\" /d /y /e >nul
)
if %doconsole%==1 (
xcopy "%backupdir1%" "%savetodir%\%backupnr%\%fname1%\" /d /y /e
)
)

:run.overwrite.prog2
if not exist "%savetodir%\auto-confirm.txt" goto fail
cls
echo Running Backup. . .
echo 2/5
title Auto Backup - Running 2/5
if not "%backupdir2%"==0 (
if %doconsole%==0 (
xcopy "%backupdir2%" "%savetodir%\%backupnr%\%fname2%\" /d /y /e >nul
)
if %doconsole%==1 (
xcopy "%backupdir2%" "%savetodir%\%backupnr%\%fname2%\" /d /y /e
)
)

:run.overwrite.prog3
if not exist "%savetodir%\auto-confirm.txt" goto fail
cls
echo Running Backup. . .
echo 3/5
title Auto Backup - Running 3/5
if not "%backupdir3%"==0 (
if %doconsole%==0 (
xcopy "%backupdir3%" "%savetodir%\%backupnr%\%fname3%\" /d /y /e >nul
)
if %doconsole%==1 (
xcopy "%backupdir3%" "%savetodir%\%backupnr%\%fname3%\" /d /y /e
)
)

:run.overwrite.prog4
if not exist "%savetodir%\auto-confirm.txt" goto fail
cls
echo Running Backup. . .
echo 4/5
title Auto Backup - Running 4/5
if not "%backupdir4%"==0 (
if %doconsole%==0 (
xcopy "%backupdir4%" "%savetodir%\%backupnr%\%fname4%\" /d /y /e >nul
)
if %doconsole%==1 (
xcopy "%backupdir4%" "%savetodir%\%backupnr%\%fname4%\" /d /y /e
)
)

:run.overwrite.prog5
if not exist "%savetodir%\auto-confirm.txt" goto fail
cls
echo Running Backup. . .
echo 5/5
title Auto Backup - Running 5/5
if not "%backupdir5%"==0 (
if %doconsole%==0 (
xcopy "%backupdir5%" "%savetodir%\%backupnr%\%fname5%\" /d /y /e >nul
)
if %doconsole%==1 (
xcopy "%backupdir5%" "%savetodir%\%backupnr%\%fname5%\" /d /y /e
)
)
if %doftp%==1 goto ftp.conf.load
goto completed

:completed
if not exist "%savetodir%\auto-confirm.txt" goto fail
title Auto Backup - Completed
( echo Set Sound = CreateObject("WMPlayer.OCX.7"^)
  echo Sound.URL = "%systemroot%\media\notify.wav"
  echo Sound.Controls.play
  echo do while Sound.currentmedia.duration = 0
  echo wscript.sleep 100
  echo loop
  echo wscript.sleep (int(Sound.currentmedia.duration^)+1^)*1000) >sound.vbs
start /min sound.vbs
echo msgbox"The Auto Bckup Program has successfully backed up all of your glorious files.",0,"Auto Backup - Msg" > msgbox.vbs
start msgbox.vbs
timeout /t 1 /nobreak >nul
del "sound.vbs" /q
del "msgbox.vbs" /q
cls
echo Backup Completed
echo.
echo (\_/)
echo (o.o)
echo (___)/
echo.
echo Exiting. . .
TIMEOUT /T 5 /NOBREAK >nul
if %shutdown%==1 goto shutdown
goto eoc

:fail
title Auto Backup - Failed
( echo Set Sound = CreateObject("WMPlayer.OCX.7"^)
  echo Sound.URL = "%systemroot%\media\chord.wav"
  echo Sound.Controls.play
  echo do while Sound.currentmedia.duration = 0
  echo wscript.sleep 100
  echo loop
  echo wscript.sleep (int(Sound.currentmedia.duration^)+1^)*1000) >sound.vbs
start /min sound.vbs
echo msgbox"The Auto Backup Program wasn't able to backup all of your glorious files.       ",0,"Auto Backup - Msg" > msgbox.vbs
start msgbox.vbs
timeout /t 1 /nobreak >nul
del "sound.vbs" /q
del "msgbox.vbs" /q
:failaf
cls
echo Backup Failed
echo Yoy may have to format the selected backup drive, to get the failed backup deleted.
echo Retrying. . .
TIMEOUT /T 2 /NOBREAK >nul
if not exist "%savetodir%\auto-confirm.txt" goto failaf
goto start

:shutdown
title Auto Backup - Completed - Shutingdown in %shutdownwait%
if %shutdownwait% GTR 10 (
( echo Set Sound = CreateObject("WMPlayer.OCX.7"^)
  echo Sound.URL = "%systemroot%\media\Windows Message Nudge.wav"
  echo Sound.Controls.play
  echo do while Sound.currentmedia.duration = 0
  echo wscript.sleep 100
  echo loop
  echo wscript.sleep (int(Sound.currentmedia.duration^)+1^)*1000) >sound.vbs
start /min sound.vbs
)
if %shutdownwait% LEQ 10 (
if %shutdownwait% GTR 1 (
( echo Set Sound = CreateObject("WMPlayer.OCX.7"^)
  echo Sound.URL = "%systemroot%\media\Windows Notify Messaging.wav"
  echo Sound.Controls.play
  echo do while Sound.currentmedia.duration = 0
  echo wscript.sleep 100
  echo loop
  echo wscript.sleep (int(Sound.currentmedia.duration^)+1^)*1000) >sound.vbs
start /min sound.vbs
)
)
if %shutdownwait% LEQ 1 (
( echo Set Sound = CreateObject("WMPlayer.OCX.7"^)
  echo Sound.URL = "%systemroot%\media\Windows Shutdown.wav"
  echo Sound.Controls.play
  echo do while Sound.currentmedia.duration = 0
  echo wscript.sleep 100
  echo loop
  echo wscript.sleep (int(Sound.currentmedia.duration^)+1^)*1000) >sound.vbs
start /min sound.vbs
)
cls
echo Waiting for another %shutdownwait% seconds. . .
choice /t 1 /n /m "Press E now to abort shutdown." /c es /d s
if %ERRORLEVEL%==1 goto abortshutdown
set /a shutdownwait=%shutdownwait%-1
if %shutdownwait%==0 goto doshutdown
goto shutdown

:doshutdown
timeout /t 1 /nobreak >nul
del "sound.vbs" /q
shutdown /s /t 0
goto eoc

:abortshutdown
timeout /t 1 /nobreak >nul
del "sound.vbs" /q
title Auto Backup
cls
echo Shutdown aborted
timeout /t 5 /nobreak >nul
goto eoc

:ftp.conf
set /a ftpconfloaded=0
cls
echo 1 = Host = %ftphost%
echo 2 = Username = %ftpusername%
if not "%ftppassword%"=="" (
echo 3 = Password = Q$¤7/£#€$!
)
if "%ftppassword%"=="" (
echo 3 = Password = 
)
echo 4 = Base directory = %ftpbasedir%
echo.
echo S = Save
echo M = Back
echo.
set /p ftpconf=Type something: 
if %ftpconf%==1 (
cls
set /p ftphost=Host: 
goto ftp.conf
)
if %ftpconf%==2 (
cls
set /p ftpusername=Username: 
goto ftp.conf
)
if %ftpconf%==3 goto ftp.enterpassword
if %ftpconf%==4 (
cls
set /p ftpbasedir=Base directory: 
goto ftp.conf
)
if %ftpconf%==s goto ftp.conf.save
if %ftpconf%==m goto config
goto ftp.conf

:ftp.conf.save
( echo set ftphost=%ftphost%
  echo set ftpusername=%ftpusername%
  echo set ftppassword=%ftppassword%
  echo set ftpbasedir=%ftpbasedir%) > ftpsettings.bat
cls
echo Config saved
timeout /t 2 /nobreak >nul
goto ftp.conf

:ftp.conf.load
call ftpsettings.bat
if "%ftpconfloaded%"=="1" goto ftp.conf
goto ftp.zip

:ftp.enterpassword
cls
echo This option is not so secure, put in a space to prompt for the password every time it's needed
echo Never leave it empty as it will cause problems!
echo If your server requires no password you should reconsider the security on your server (Put a password on it!)
echo.
set "psCommand=powershell -Command "$pword = read-host 'Password' -AsSecureString ; ^
    $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword); ^
        [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
for /f "usebackq delims=" %%a in (`%psCommand%`) do set ftppassword=%%a
goto ftp.conf

:ftp.zip
set ftpzipfilename=%date%.zip
title Auto Backup - Zipping
cls
echo Zipping backup. . .
call 7zg.exe a -t7z "%savetodir%\%ftpzipfilename%" -r "%savetodir%\%backupnr%\*"
goto ftp.upload

:ftp.upload
title Auto Backup - Uploading. . .
if not "%ftppassword%"=="" goto ftp.upload.pass
cls
set "psCommand=powershell -Command "$pword = read-host 'Password' -AsSecureString ; ^
    $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword); ^
        [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
for /f "usebackq delims=" %%a in (`%psCommand%`) do set ftppassword=%%a
if not "%ftppassword%"=="" (
cls
echo Still no password?!?
echo.
pause
)
:ftp.upload.pass
cls
echo Uploading to FTP. . .
( echo open %ftphost%
  echo %ftpusername%
  echo %ftppassword%
  echo cd %ftpbasedir%
  echo binary 
  echo lcd "%savetodir%"
  echo put %ftpzipfilename%
  echo bye) > ftp.txt
ftp -i -s:ftp.txt >nul
del "ftp.txt" /q >nul
timeout /t 4 /nobreak >nul
del "%savetodir%\%ftpzipfilename%" /q >nul
if %delafterftp%==1 (
rmdir "%savetodir%\%backupnr%" /s /q
)
goto completed

:ftp.error
title Auto Backup - ERROR
cls
echo Could not make zip file.
echo.
goto menu

:easteregg
set /a easteregg=%easteregg%-1
title Auto Backup - %easteregg%
cls
color 00
cls
color 10
cls
color 20
cls
color 30
cls
color 40
cls
color 50
cls
color 60
cls
color 70
cls
color 80
cls
color 90
cls
color a0
cls
color b0
cls
color c0
cls
color d0
cls
color e0
cls
color f0
cls
color 07
if %easteregg%==0 goto menu
goto easteregg

:debuge
title Auto Backup - Enter debug mode
cls
echo Enter debug mode
choice /n /m "(Y/N)" /c yn
if %ERRORLEVEL%==1 (
cls
goto debug
)
if %ERRORLEVEL%==2 (
cls
goto menu
)

:debug
title Auto Backup - Enter Password
@echo off
cls
if "%passcorr%"=="1" goto debugcorr
set "psCommand=powershell -Command "$pword = read-host 'Enter Password' -AsSecureString ; ^
    $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword); ^
        [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
for /f "usebackq delims=" %%a in (`%psCommand%`) do set password=%%a
if %password%==ABP2017 goto debugcorr
echo.
echo Password incorrect!
echo.
pause
goto debug

:debugcorr
set /a passcorr=1 
cls
echo Auto Backup Program V.%currentversion%
goto debugpassed

:debugpassed
title Auto Backup - Debug
echo.
set /p debug="%cd%>"
%debug%
goto debugpassed

:convertformat
if not exist "Backup-config.txt" (
cls
echo The old file is missing
if exist "settings.bat" (
echo.
echo You allready have the new format
)
echo.
pause
goto menu
)
title Auto Backup - Loading. . .
cls
for /f "Tokens=2 Delims=." %%a in (Backup-config.txt) do (
set savetodir=%%a
)
for /f "Tokens=4 Delims=." %%a in (Backup-config.txt) do (
set backupdir1=%%a
)
for /f "Tokens=6 Delims=." %%a in (Backup-config.txt) do (
set backupdir2=%%a
)
for /f "Tokens=8 Delims=." %%a in (Backup-config.txt) do (
set backupdir3=%%a
)
for /f "Tokens=10 Delims=." %%a in (Backup-config.txt) do (
set backupdir4=%%a
)
for /f "Tokens=12 Delims=." %%a in (Backup-config.txt) do (
set backupdir5=%%a
)
for /f "Tokens=14 Delims=." %%a in (Backup-config.txt) do (
set fname1=%%a
)
for /f "Tokens=16 Delims=." %%a in (Backup-config.txt) do (
set fname2=%%a
)
for /f "Tokens=18 Delims=." %%a in (Backup-config.txt) do (
set fname3=%%a
)
for /f "Tokens=20 Delims=." %%a in (Backup-config.txt) do (
set fname4=%%a
)
for /f "Tokens=22 Delims=." %%a in (Backup-config.txt) do (
set fname5=%%a
)
for /f "Tokens=24 Delims=." %%a in (Backup-config.txt) do (
set saveamount=%%a
)
for /f "Tokens=26 Delims=." %%a in (Backup-config.txt) do (
set shutdown=%%a
)
for /f "Tokens=28 Delims=." %%a in (Backup-config.txt) do (
set doconsole=%%a
)
for /f "Tokens=30 Delims=." %%a in (Backup-config.txt) do (
set doftp=%%a
)
( echo set savetodir=%savetodir%
  echo set backupdir1=%backupdir1%
  echo set backupdir2=%backupdir2%
  echo set backupdir3=%backupdir3%
  echo set backupdir4=%backupdir4%
  echo set backupdir5=%backupdir5%
  echo set fname1=%fname1%
  echo set fname2=%fname2%
  echo set fname3=%fname3%
  echo set fname4=%fname4%
  echo set fname5=%fname5%
  echo set saveamount=%saveamount%
  echo set shutdown=%shutdown%
  echo set doconsole=%doconsole%
  echo set doftp=%doftp%
  echo set delafterftp=%delafterftp%) > settings.bat
del Backup-config.txt /q >nul
cls
echo Config converted
echo.
pause
goto eoc

:eoc
echo.
echo Goodbye.
timeout /t 1 /nobreak >nul