@echo off
setlocal

echo Pulling changes...
cd %USERPROFILE%\AppData\LocalLow\IronGate\Valheim\valheim_git_repo
git pull
if errorlevel 1 (
    echo Git pull failed. Exiting script.
    exit /b 1
)

echo Copying world files...
set "WORLD_NAME=MyWorld"
copy /Y "%WORLD_NAME%.db" "%USERPROFILE%\AppData\LocalLow\IronGate\Valheim\worlds_local"
copy /Y "%WORLD_NAME%.fwl" "%USERPROFILE%\AppData\LocalLow\IronGate\Valheim\worlds_local"

echo Starting Valheim...
start steam://run/892970
timeout /t 10 >nul

:waitLoop
tasklist /FI "IMAGENAME eq valheim.exe" | find /I "valheim.exe" >nul
if not errorlevel 1 (
    timeout /t 5 >nul
    goto waitLoop
)

echo Saving world files...
copy /Y "%USERPROFILE%\AppData\LocalLow\IronGate\Valheim\worlds_local\%WORLD_NAME%.db" ".\"
copy /Y "%USERPROFILE%\AppData\LocalLow\IronGate\Valheim\worlds_local\%WORLD_NAME%.fwl" ".\"

echo Valheim closed, committing changes...
for /f "tokens=*" %%a in ('date /T') do set currentDate=%%a
for /f "tokens=*" %%b in ('time /T') do set currentTime=%%b
set commitMsg=%currentDate% at %currentTime%
git commit -a -m "%commitMsg%"
git push

echo Done.
endlocal