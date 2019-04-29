cd %~dp0 & cd ..

set COMMON_ASSET_DIR=.\assets\common
if not exist "%COMMON_ASSET_DIR%" mkdir %COMMON_ASSET_DIR%
if errorlevel 1 goto error

if "%PLATFORM%" == "windows" (
	set PLATFORM_ASSET_DIR=.\assets\windows
) else if "%PLATFORM%" == "android" (
	set PLATFORM_ASSET_DIR=.\assets\android
) else if "%PLATFORM%" == "ios-dev" (
	set PLATFORM_ASSET_DIR=.\assets\ios
) else if "%PLATFORM%" == "ios-dist" (
	set PLATFORM_ASSET_DIR=.\assets\ios
) else (
	goto error
)

if not exist "%PLATFORM_ASSET_DIR%" mkdir %PLATFORM_ASSET_DIR%
if errorlevel 1 goto error

:end
exit /b 0

:error
exit /b 1
