@echo off
chcp 65001 >nul

:top
cls
echo.
echo Uninstall MIUI apps?
echo.
set /p input="Type "amen" to proceed> "
if /i "%input%"=="amen" goto :amen
goto :top

:amen
echo Google Podcasts
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.podcasts

:: echo Google Pay
:: %~dp0adb shell pm uninstall --user 0 com.google.android.apps.walletnfcrel

echo Google One
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.subscriptions.red

echo Google News
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.magazines

echo Duo
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.tachyon

echo Documents
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.docs.editors.docs

echo Family Link child and teen
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.kids.familylinkhelper

echo Pixel Live Wallpaper
%~dp0adb shell pm uninstall --user 0 com.google.pixel.livewallpaper

echo Google Assistant
%~dp0adb shell pm uninstall --user 0 com.android.hotwordenrollment.xgoogle
%~dp0adb shell pm uninstall --user 0 com.android.hotwordenrollment.okgoogle

echo SIM Toolkit
%~dp0adb shell pm uninstall --user 0 com.android.stk

echo Gmail
%~dp0adb shell pm uninstall --user 0 com.google.android.gm

echo YouTube
%~dp0adb shell pm uninstall --user 0 com.google.android.youtube

echo Digital Wellbeing
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.wellbeing

echo Google Files
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.nbu.files

echo Google Drive
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.docs

echo Maps
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.maps

echo Chrome
%~dp0adb shell pm uninstall --user 0 com.android.chrome

echo Google TV
%~dp0adb shell pm uninstall --user 0 com.google.android.videos

echo Google Photos
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.photos

echo Pixel Live Wallpaper
%~dp0adb shell pm uninstall --user 0 com.android.wallpaper.livewallpaper

echo Bookmark Provider
%~dp0adb shell pm uninstall --user 0 com.android.bookmarkprovider

:: echo Android Auto
:: %~dp0adb shell pm uninstall --user 0 com.google.android.projection.gearhead

echo Google
%~dp0adb shell pm uninstall --user 0 com.google.android.googlequicksearchbox

echo Sound recorder
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.recorder

echo Google Location History
%~dp0adb shell pm uninstall --user 0 com.google.android.gms.location.history

echo YouTube Music
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.youtube.music

echo Pixel Tips
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.tips

echo My Verizon Services
%~dp0adb shell pm uninstall --user 0 com.verizon.mips.services

echo Pixel Buds
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.wearables.maestro.companion

echo Google Support Services
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.helprtc

echo Personal Safety
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.safetyhub

adb kill-server
echo.

taskkill /F /IM adb.exe /T 2>NUL

RMDIR /S /Q %USERPROFILE%\.android 2>NUL
RMDIR /S /Q %USERPROFILE%\.dbus-keyrings 2>NUL
pause
