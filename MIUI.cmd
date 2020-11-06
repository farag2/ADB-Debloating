@echo off
chcp 65001 >nul

:top
cls
echo.
echo Uninstall MIUI apps?
echo.
set /p input="Enter "amen" for "yes"> "
if /i "%input%"=="amen" goto :amen
goto :top

:amen
echo WPS Office
%~dp0adb shell pm uninstall --user 0 cn.wps.moffice_eng

echo Средство просмотра документов Mi (на платформе WPS)
%~dp0adb shell pm uninstall --user 0 cn.wps.xiaomi.abroad.lite

echo Aliexpress
%~dp0adb shell pm uninstall --user 0 com.alibaba.aliexpresshd

echo Юла
%~dp0adb shell pm uninstall --user 0 com.allgoritm.youla

echo Bookmark Provider
%~dp0adb shell pm uninstall --user 0 com.android.bookmarkprovider

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

echo Booking.com
%~dp0adb shell pm uninstall --user 0 com.booking

echo Mi Пульт
%~dp0adb shell pm uninstall --user 0 com.duokan.phone.remotecontroller

echo eBay Partner Attribution
%~dp0adb shell pm uninstall --user 0 com.ebay.carrier

echo eBay
%~dp0adb shell pm uninstall --user 0 com.ebay.mobile

echo YouTube
%~dp0adb shell pm uninstall --user 0 com.google.android.youtube

echo YouTube Music
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.youtube.music

echo Android Accessibility Suite
%~dp0adb shell pm uninstall --user 0 com.google.android.marvin.talkback

echo Facebook
%~dp0adb shell pm uninstall --user 0 com.facebook.katana

%~dp0adb shell pm uninstall --user 0 com.facebook.system

%~dp0adb shell pm uninstall --user 0 com.facebook.appmanager

%~dp0adb shell pm uninstall --user 0 com.facebook.services

echo Google Диск
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.docs

echo Ассистент
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.googleassistant

echo Google Новости
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.magazines

echo Карты
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.maps

echo Google Фото
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.photos

echo Google Podcasts
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.podcasts

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

echo Android One
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.subscriptions.red

echo Google Play Фильмы
%~dp0adb shell pm uninstall --user 0 com.google.android.videos

echo Объектив
%~dp0adb shell pm uninstall --user 0 com.google.ar.lens

echo Google Play Services for AR
%~dp0adb shell pm uninstall --user 0 com.google.ar.core

echo Mi Браузер
:: Невозможно удалить
%~dp0adb shell pm disable-user --user 0 com.mi.globalbrowser

echo Карусель обоев
:: Невозможно удалить
%~dp0adb shell pm disable-user --user 0 com.miui.android.fashiongallery

echo Проводник
:: Становится невозможно выбрать прошивку через 3 точки
%~dp0adb shell pm uninstall --user 0 com.mi.android.globalFileexplorer

echo Лента виджетов
%~dp0adb shell pm uninstall --user 0 com.mi.android.globalminusscreen

echo Mi Credit
%~dp0adb shell pm uninstall --user 0 com.micredit.in

echo Mi Community
%~dp0adb shell pm uninstall --user 0 com.mi.global.bbs

echo Mi Store
%~dp0adb shell pm uninstall --user 0 com.mi.global.shop

echo MiDrive
%~dp0adb shell pm uninstall --user 0 com.miui.newmidrive

echo Mi Mover
%~dp0adb shell pm uninstall --user 0 com.miui.huanji

echo Быстрые приложения
%~dp0adb shell pm uninstall --user 0 com.miui.hybrid

echo Заметки
%~dp0adb shell pm uninstall --user 0 com.miui.notes

echo Справочник
%~dp0adb shell pm uninstall --user 0 com.miui.yellowpage

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

echo ShareMe
%~dp0adb shell pm uninstall --user 0 com.miui.mishare.connectivity
%~dp0adb shell pm uninstall --user 0 com.xiaomi.midrop

echo msa
%~dp0adb shell pm uninstall --user 0 com.miui.msa.global

echo Музыка
%~dp0adb shell pm uninstall --user 0 com.miui.player

echo Mi Видео
:: На некоторых устройствах невозможно удалить, а только отключить
%~dp0adb shell pm uninstall --user 0 com.miui.videoplayer

echo PartnerNetflixActivation
%~dp0adb shell pm uninstall --user 0 com.netflix.partner.activation

echo Opera
%~dp0adb shell pm uninstall --user 0 com.opera.browser
%~dp0adb shell pm uninstall --user 0 com.opera.preinstall

echo Qualcomm Voice Assist
%~dp0adb shell pm uninstall --user 0 com.quicinc.voice.activation

echo Joyose
%~dp0adb shell pm uninstall --user 0 com.xiaomi.joyose

echo Сканер
:: Становится невозможным сканировать QR-коды через камеру
%~dp0adb shell pm uninstall --user 0 com.xiaomi.scanner

echo Игры
%~dp0adb shell pm uninstall --user 0 com.xiaomi.glgm

echo Mi Picks
%~dp0adb shell pm uninstall --user 0 com.xiaomi.mipicks

echo Дзен
%~dp0adb shell pm uninstall --user 0 com.yandex.zen

echo TikTok
%~dp0adb shell pm uninstall --user 0 com.zhiliaoapp.musically

echo Яндекс
%~dp0adb shell pm uninstall --user 0 ru.yandex.searchplugin

echo ZenkitPartnerConfig
%~dp0adb shell pm uninstall --user 0 com.yandex.zenkitpartnerconfig

%~dp0adb kill-server
echo.

RMDIR /S /Q %USERPROFILE%\.android
RMDIR /S /Q %USERPROFILE%\.dbus-keyrings
pause
