@echo off
title Updater.exe
if not %1%==ABP2017 exit
echo Updating. . .
( echo open ftpp.ostentv.dk
  echo autobackup
  echo Thispageisnolongerpublic
  echo cd install
  echo binary 
  echo lcd "%cd%"
  echo mget *.*
  echo bye) > updater.txt
ftp -i -s:updater.txt >nul
del updater.txt /q
cls
echo Update Completed.
pause
start autobackup.exe
exit