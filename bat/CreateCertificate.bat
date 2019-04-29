@echo off

:: Set working dir
cd %~dp0 & cd ..

set PAUSE_ERRORS=1
set PLATFORM=windows
call bat\SetupSDK.bat
call bat\SetupApp.bat

:: Generate
echo.
echo Generating a self-signed certificate...
call adt -certificate -cn "%WIN_AND_CERT_NAME%" -ou "%WIN_AND_CERT_ORG_UNIT%" -o "%WIN_AND_CERT_ORG_NAME%" -c "%WIN_AND_CERT_COUNTRY%" -validityPeriod %WIN_AND_CERT_YEARS% 2048-RSA "%WIN_AND_CERT_FILE%" "%WIN_AND_CERT_PASS%"
if errorlevel 1 goto failed

:succeed
echo.
echo Certificate created: %WIN_AND_CERT_FILE% with password "%WIN_AND_CERT_PASS%"
echo.
if "%WIN_AND_CERT_PASS%" == "fd" echo Note: You did not change the default password
echo.
echo HINTS:
echo - you only need to generate this certificate once,
echo - wait a minute before using this certificate to package your AIR application.
echo.
goto end

:failed
echo.
echo Certificate creation FAILED.
echo.

:end
pause
