@echo off
chcp 65001 >nul

:top
set input=
cls
echo.
echo Remove MIUI apps?
echo.
set /p input="Enter amen for Yes> "
if /i "%input%"=="amen" goto :amen
goto :top

:amen
echo Юла
%~dp0adb shell pm uninstall --user 0 com.allgoritm.youla
echo Bookmark Provider
%~dp0adb shell pm uninstall --user 0 com.android.bookmarkprovider
echo Браузер
%~dp0adb shell pm uninstall --user 0 com.android.browser
echo Chrome
%~dp0adb shell pm uninstall --user 0 com.android.chrome
echo Загрузки
%~dp0adb shell pm uninstall --user 0 com.android.providers.downloads.ui
echo Диктофон
%~dp0adb shell pm uninstall --user 0 com.android.soundrecorder
echo Меню SIM-карты
%~dp0adb shell pm uninstall --user 0 com.android.stk
echo Каталог живых обоев
%~dp0adb shell pm uninstall --user 0 com.android.wallpaper.livepicker
echo YouTube
%~dp0adb shell pm uninstall --user 0 com.google.android.youtube
echo Android Accessibility Suite
%~dp0adb shell pm uninstall --user 0 com.google.android.marvin.talkback
echo Facebook
%~dp0adb shell pm uninstall --user 0 com.facebook.katana
%~dp0adb shell pm uninstall --user 0 com.facebook.system
%~dp0adb shell pm uninstall --user 0 com.facebook.appmanager
%~dp0adb shell pm uninstall --user 0 com.facebook.services
echo Google Диск
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.docs
echo Карты
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.maps
echo Google Фото
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.photos
echo Duo
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.tachyon
echo Device Health Services
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.turbo
echo Цифровое благополучие
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.wellbeing
echo Gmail
%~dp0adb shell pm uninstall --user 0 com.google.android.gm
echo Google
%~dp0adb shell pm uninstall --user 0 com.google.android.googlequicksearchbox
echo Google Play Музыка
%~dp0adb shell pm uninstall --user 0 com.google.android.music
echo Google Play Игры
%~dp0adb shell pm uninstall --user 0 com.google.android.play.games
echo Android Auto
%~dp0adb shell pm uninstall --user 0 com.google.android.projection.gearhead
echo Google Play Фильмы
%~dp0adb shell pm uninstall --user 0 com.google.android.videos
echo Объектив
%~dp0adb shell pm uninstall --user 0 com.google.ar.lens
echo Google Play Services for AR
%~dp0adb shell pm uninstall --user 0 com.google.ar.core
echo Карусель обоев
%~dp0adb shell pm uninstall --user 0 com.miui.android.fashiongallery
echo Mi Mover
%~dp0adb shell pm uninstall --user 0 com.miui.huanji
echo Быстрые приложения
%~dp0adb shell pm uninstall --user 0 com.miui.hybrid
echo Заметки
%~dp0adb shell pm uninstall --user 0 com.miui.notes
echo Справочник
%~dp0adb shell pm uninstall --user 0 com.miui.yellowpage
echo Проводник
%~dp0adb shell pm uninstall --user 0 com.mi.android.globalFileexplorer
echo Лента виджетов
%~dp0adb shell pm uninstall --user 0 com.mi.android.globalminusscreen
echo Analytics
%~dp0adb shell pm uninstall --user 0 com.miui.analytics
echo Компас
%~dp0adb shell pm uninstall --user 0 com.miui.compass
echo FM-радио
%~dp0adb shell pm uninstall --user 0 com.miui.fm
echo Служба FM радио
%~dp0adb shell pm uninstall --user 0 com.miui.fmservice
echo Сервисы и обратная связь
%~dp0adb shell pm uninstall --user 0 com.miui.miservice
echo msa
%~dp0adb shell pm uninstall --user 0 com.miui.msa.global
echo Музыка
%~dp0adb shell pm uninstall --user 0 com.miui.player
echo Mi Видео
%~dp0adb shell pm uninstall --user 0 com.miui.videoplayer
echo PartnerNetflixActivation
%~dp0adb shell pm uninstall --user 0 com.netflix.partner.activation
echo Joyose
%~dp0adb shell pm uninstall --user 0 com.xiaomi.joyose
echo Сканер
%~dp0adb shell pm uninstall --user 0 com.xiaomi.scanner
echo Игры
%~dp0adb shell pm uninstall --user 0 com.xiaomi.glgm
echo GetApps
%~dp0adb shell pm uninstall --user 0 com.xiaomi.mipicks
echo GetApps
%~dp0adb shell pm uninstall --user 0 ru.yandex.searchplugin

%~dp0adb kill-server
echo.
RMDIR /S /Q %USERPROFILE%\.android
RMDIR /S /Q %USERPROFILE%\.dbus-keyrings
pause
