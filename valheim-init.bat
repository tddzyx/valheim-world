@echo off
setlocal

:: Set the target directory
set "TARGET_DIR=%USERPROFILE%\AppData\LocalLow\IronGate\Valheim\valheim_git_repo"

:: Set the repository URL
set "REPO_URL=https://github.com/tddzyx/valheim-world.git"

:: Create the target directory if it doesn't exist
if not exist "%TARGET_DIR%" (
    echo Creating directory...
    mkdir "%TARGET_DIR%"
)

:: Navigate to the target directory
cd /d "%TARGET_DIR%"

:: Clone the repository
git clone "%REPO_URL%" .

echo Copying world files...
set "WORLD_NAME=TheDogHouse"
copy /Y "%TARGET_DIR%\%WORLD_NAME%.db" "%USERPROFILE%\AppData\LocalLow\IronGate\Valheim\worlds_local"
copy /Y "%TARGET_DIR%\%WORLD_NAME%.fwl" "%USERPROFILE%\AppData\LocalLow\IronGate\Valheim\worlds_local"

echo Done.
endlocal