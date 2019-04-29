:: Set working dir
cd %~dp0 & cd ..

:menu
echo.
echo Package for target
echo.
echo  [1] Windows
echo  [2] Android
echo  [3] iOS(Test)
echo  [4] iOS(AppStore)
echo.

:choice
set /P C=[Choice]:
echo.

set PLATFORM=windows
if "%C%"=="1" set PLATFORM=windows
if "%C%"=="2" set PLATFORM=android
if "%C%"=="3" set PLATFORM=ios-dev
if "%C%"=="4" set PLATFORM=ios-dist
