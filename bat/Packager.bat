@echo off

:: Set working dir
cd %~dp0 & cd ..

:: check cert file
if not exist %CERT_FILE% goto certificate

:: create AIR path directory
if not exist %AIR_PATH% md %AIR_PATH%

:: Package
echo.
echo Packaging: %PLATFORM%
echo.
if "%PLATFORM%" == "windows" (
	call adt -package %SIGNING_OPTIONS% %PKG_OPTION% %OUTPUT% %APP_XML% -C %APP_DIR% %SWF_FILE% %ICONS% %FILE_OR_DIR% %EXT_DIR%
) else if "%PLATFORM%" == "android" (
	call adt -package %PKG_OPTION% %SIGNING_OPTIONS% %OUTPUT% %APP_XML% -C %APP_DIR% %SWF_FILE% %ICONS% %FILE_OR_DIR% %EXT_DIR%
) else if "%PLATFORM%" == "ios-dev" (
	call adt -package %PKG_OPTION% %SIGNING_OPTIONS% %OUTPUT% %APP_XML% -C %APP_DIR% %SWF_FILE% %ICONS% %FILE_OR_DIR% %EXT_DIR%
) else if "%PLATFORM%" == "ios-dist" (
	call adt -package %PKG_OPTION% %SIGNING_OPTIONS% %OUTPUT% %APP_XML% -C %APP_DIR% %SWF_FILE% %ICONS% %FILE_OR_DIR% %EXT_DIR%
)
if errorlevel 1 goto failed
goto end

:certificate
echo.
echo Certificate not found: %CERT_FILE%
echo.
echo Troubleshooting:
echo - generate a default certificate using 'bat\CreateCertificate.bat'
echo.
if %PAUSE_ERRORS%==1 pause
exit

:failed
echo adt FAILED.
if %PAUSE_ERRORS%==1 pause
exit

:end
echo.
