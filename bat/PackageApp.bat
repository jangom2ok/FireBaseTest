@echo off

:: Set working dir
cd %~dp0 & cd ..

set PAUSE_ERRORS=1
call bat\Menu.bat
call bat\CreateAssetDir.bat
if errorlevel 1 goto error
call bat\SetupSDK.bat
call bat\SetupApp.bat

call bat\Packager.bat

pause
goto end

:error
echo.
echo ERROR : Can't create assets directory.
pause

:end