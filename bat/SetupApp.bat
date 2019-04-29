:: Set working dir
cd %~dp0 & cd ..

:user_configuration

:: About AIR application packaging
:: http://livedocs.adobe.com/flex/3/html/help.html?content=CommandLineTools_5.html#1035959
:: http://livedocs.adobe.com/flex/3/html/distributing_apps_4.html#1037515

:: NOTICE: all paths are relative to project root

:: AppDir
set APP_DIR=.\bin
set SWF_FILE=Thinks.swf

:: Output
set AIR_PATH=air

:: Your certificate information
set WIN_AND_CERT_NAME=Talkie
set WIN_AND_CERT_PASS=talkie1124
set WIN_AND_CERT_ORG_UNIT=development
set WIN_AND_CERT_ORG_NAME=Talkie System Co.,Ltd.
set WIN_AND_CERT_COUNTRY=JP
set WIN_AND_CERT_YEARS=25
set WIN_AND_CERT_FILE=.\bat\Thinks.p12

:: Windows packaging
set WIN_SIGNING_OPTIONS=-storetype pkcs12 -keystore "%WIN_AND_CERT_FILE%" -storepass %WIN_AND_CERT_PASS% -tsa none
set WIN_OUTPUT=Thinks
set WIN_APP_XML=application_windows.xml
set WIN_FILE_OR_DIR=-C ./assets/common . -C ./assets/windows .
set WIN_ICONS=-C assets\icons .
set WIN_EXT_DIR=-extdir libs

:: Android packaging
set AND_SIGNING_OPTIONS=-storetype pkcs12 -keystore "%WIN_AND_CERT_FILE%" -storepass %WIN_AND_CERT_PASS%
set AND_OUTPUT=Thinks.apk
set AND_APP_XML=application_android.xml
set AND_FILE_OR_DIR=-C ./assets/common . -C ./assets/android .
set AND_ICONS=-C assets\icons .
set AND_EXT_DIR=-extdir libs

:: iOS packaging
set IOS_DEV_CERT_FILE=C:\develop\iosdev\TalkieDemo\TalkieiOS.p12
set IOS_DEV_CERT_PASS=talkie1124
set IOS_DEV_PROVISION=C:\develop\iosdev\TalkieDemo\Thinks_develop.mobileprovision
set IOS_DEV_SIGNING_OPTIONS=-storetype pkcs12 -keystore "%IOS_DEV_CERT_FILE%" -storepass %IOS_DEV_CERT_PASS% -provisioning-profile %IOS_DEV_PROVISION%
set IOS_DEV_OUTPUT=Thinks_dev.ipa
set IOS_DEV_APP_XML=application_ios_dev.xml
set IOS_DIST_CERT_FILE=C:\develop\iosdev\TalkieDemo\TalkieiOS.p12
set IOS_DIST_CERT_PASS=talkie1124
set IOS_DIST_PROVISION=C:\develop\iosdev\TalkieDemo\Thinks_distriibution.mobileprovision
set IOS_DIST_SIGNING_OPTIONS=-storetype pkcs12 -keystore "%IOS_DIST_CERT_FILE%" -storepass %IOS_DIST_CERT_PASS% -provisioning-profile %IOS_DIST_PROVISION%
set IOS_DIST_OUTPUT=Thinks_dist.ipa
set IOS_DIST_APP_XML=application_ios_dist.xml
set IOS_FILE_OR_DIR=-C ./assets/common . -C ./assets/ios .
set IOS_ICONS=-C assets\icons .
set IOS_EXT_DIR=-extdir libs

:: user_configuration end

:: setup
if "%PLATFORM%" == "windows" (
	set SIGNING_OPTIONS=%WIN_SIGNING_OPTIONS%
	set CERT_FILE=%WIN_AND_CERT_FILE%
	set OUTPUT=%AIR_PATH%\%WIN_OUTPUT%
	set APP_XML=%WIN_APP_XML%
	set FILE_OR_DIR=%WIN_FILE_OR_DIR%
	set ICONS=%WIN_ICONS%
	set PKG_OPTION=-target bundle
	set EXT_DIR=%WIN_EXT_DIR%
) else if "%PLATFORM%" == "android" (
	set SIGNING_OPTIONS=%AND_SIGNING_OPTIONS%
	set CERT_FILE=%WIN_AND_CERT_FILE%
	set OUTPUT=%AIR_PATH%\%AND_OUTPUT%
	set APP_XML=%AND_APP_XML%
	set FILE_OR_DIR=%AND_FILE_OR_DIR%
	set ICONS=%AND_ICONS%
	set PKG_OPTION=-target apk-captive-runtime -arch armv7
::	set PKG_OPTION=-target apk-captive-runtime -arch x86
	set EXT_DIR=%AND_EXT_DIR%
) else if "%PLATFORM%" == "ios-dev" (
	set SIGNING_OPTIONS=%IOS_DEV_SIGNING_OPTIONS%
	set CERT_FILE=%IOS_DEV_CERT_FILE%
	set OUTPUT=%AIR_PATH%\%IOS_DEV_OUTPUT%
	set APP_XML=%IOS_DEV_APP_XML%
	set FILE_OR_DIR=%IOS_FILE_OR_DIR%
	set ICONS=%IOS_ICONS%
	set PKG_OPTION=-target ipa-test
::	set PKG_OPTION=-target ipa-debug -connect 192.168.0.2
	set EXT_DIR=%IOS_EXT_DIR%
) else if "%PLATFORM%" == "ios-dist" (
	set SIGNING_OPTIONS=%IOS_DIST_SIGNING_OPTIONS%
	set CERT_FILE=%IOS_DIST_CERT_FILE%
	set OUTPUT=%AIR_PATH%\%IOS_DIST_OUTPUT%
	set APP_XML=%IOS_DIST_APP_XML%
	set FILE_OR_DIR=%IOS_FILE_OR_DIR%
	set ICONS=%IOS_ICONS%
	set PKG_OPTION=-target ipa-app-store
	set EXT_DIR=%IOS_EXT_DIR%
)

:: Your application ID (must match <id> of Application descriptor) and remove spaces
for /f "tokens=3 delims=<>" %%a in ('findstr /R /C:"^[ 	]*<id>" %APP_XML%') do set APP_ID=%%a
set APP_ID=%APP_ID: =%

:validation
findstr /C:"<id>%APP_ID%</id>" "%APP_XML%" > NUL
if errorlevel 1 goto badid
goto end

:badid
echo.
echo ERROR:
echo   Application ID in 'bat\SetupApp.bat' (APP_ID)
echo   does NOT match Application descriptor '%APP_XML%' (id)
echo.
if %PAUSE_ERRORS%==1 pause
exit

:end
