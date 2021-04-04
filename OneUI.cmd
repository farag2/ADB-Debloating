@echo off
chcp 65001 >nul

:top
cls
echo.
echo Uninstall One UI apps?
echo.
set /p input="Type "amen" to proceed> "
if /i "%input%"=="amen" goto :amen
goto :top

:amen
echo Ar Zone
%~dp0adb shell pm uninstall --user 0 com.samsung.android.arzone

echo Ar-зарисовка
%~dp0adb shell pm uninstall --user 0 com.samsung.android.ardrawing

echo Ar-приложения
%~dp0adb shell pm uninstall --user 0 com.samsung.android.visionarapps

echo Bixby
%~dp0adb shell pm uninstall --user 0 com.samsung.android.bixby.agent

echo Bixby Vision
%~dp0adb shell pm uninstall --user 0 com.samsung.android.visionintelligence

echo Bixby Voice
%~dp0adb shell pm uninstall --user 0 com.samsung.android.bixby.agent.dummy

echo Bixby Vision Framework
%~dp0adb shell pm uninstall --user 0 com.samsung.android.bixbyvision.framework

echo Bookmark Provider
%~dp0adb shell pm uninstall --user 0 com.android.bookmarkprovider

echo Briefing
%~dp0adb shell pm uninstall --user 0 flipboard.boxer.app

echo Chrome
%~dp0adb shell pm uninstall --user 0 com.android.chrome

echo DECO PIC
%~dp0adb shell pm uninstall --user 0 com.samsung.android.livestickers

echo Dex для ПК
%~dp0adb shell pm uninstall --user 0 com.sec.android.app.dexonpc

echo Device Health Services
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.turbo

echo Duo
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.tachyon

echo Facebook
%~dp0adb shell pm uninstall --user 0 com.facebook.katana
%~dp0adb shell pm uninstall --user 0 com.facebook.system
%~dp0adb shell pm uninstall --user 0 com.facebook.appmanager
%~dp0adb shell pm uninstall --user 0 com.facebook.services

echo Galaxy Themes
%~dp0adb shell pm uninstall --user 0 com.samsung.android.themestore

echo Galaxy Wearable
%~dp0adb shell pm uninstall --user 0 com.samsung.android.app.watchmanager

echo Game Booster
%~dp0adb shell pm uninstall --user 0 com.samsung.android.game.gametools

echo Game Launcher
%~dp0adb shell pm uninstall --user 0 com.samsung.android.game.gamehome

echo Game Optimizing Service
%~dp0adb shell pm uninstall --user 0 com.samsung.android.game.gos

echo Gmail
%~dp0adb shell pm uninstall --user 0 com.google.android.gm

echo Google
%~dp0adb shell pm uninstall --user 0 com.google.android.googlequicksearchbox

echo Google Play Services for AR
%~dp0adb shell pm uninstall --user 0 com.google.ar.core

echo Google Play Фильмы
%~dp0adb shell pm uninstall --user 0 com.google.android.videos

echo Google Ассистент
%~dp0adb shell pm uninstall --user 0 com.android.hotwordenrollment.xgoogle
%~dp0adb shell pm uninstall --user 0 com.android.hotwordenrollment.okgoogle

echo Google Фото
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.photos

echo Health Service
%~dp0adb shell pm uninstall --user 0 com.sec.android.service.health

echo Link Sharing
%~dp0adb shell pm uninstall --user 0 com.samsung.android.app.simplesharing

echo Office
%~dp0adb shell pm uninstall --user 0 com.microsoft.office.officehubrow

echo OneDrive
%~dp0adb shell pm uninstall --user 0 com.microsoft.skydrive

echo Outlook
%~dp0adb shell pm uninstall --user 0 com.microsoft.office.outlook

echo Private Share
%~dp0adb shell pm uninstall --user 0 com.samsung.android.privateshare

echo Samsung Daily
%~dp0adb shell pm uninstall --user 0 com.samsung.android.app.spage

echo Samsung DeX
%~dp0adb shell pm uninstall --user 0 com.sec.android.desktopmode.uiservice

echo Samsung Galaxy Friends
%~dp0adb shell pm uninstall --user 0 com.samsung.android.mateagent

echo Samsung Global Goals
%~dp0adb shell pm uninstall --user 0 com.samsung.sree

echo Samsung Health
%~dp0adb shell pm uninstall --user 0 com.sec.android.app.shealth

echo Samsung Internet
%~dp0adb shell pm uninstall --user 0 com.sec.android.app.sbrowser

echo Samsung Kids
%~dp0adb shell pm uninstall --user 0 com.sec.android.app.kidshome

echo Samsung Notes
%~dp0adb shell pm uninstall --user 0 com.samsung.android.app.notes

echo Samsung Pass
%~dp0adb shell pm uninstall --user 0 com.samsung.android.authfw

echo Samsung Pass Provider
%~dp0adb shell pm uninstall --user 0 com.samsung.android.samsungpass

echo Samsung Pay
%~dp0adb shell pm uninstall --user 0 com.samsung.android.spay

echo Secure Folder
%~dp0adb shell pm uninstall --user 0 com.samsung.knox.securefolder

echo SmartThings
%~dp0adb shell pm uninstall --user 0 com.samsung.android.beaconmanager
%~dp0adb shell pm uninstall --user 0 com.samsung.android.oneconnect

echo SwiftKey factory settings
%~dp0adb shell pm uninstall --user 0 com.touchtype.swiftkey
%~dp0adb shell pm uninstall --user 0 com.swiftkey.swiftkeyconfigurator

echo Wearable Manager Installer
%~dp0adb shell pm uninstall --user 0 com.samsung.android.app.watchmanagerstub

echo YouTube
%~dp0adb shell pm uninstall --user 0 com.google.android.youtube

echo YouTube Music
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.youtube.music

echo Автозаполнение с Samsung Pass
%~dp0adb shell pm uninstall --user 0 com.samsung.android.samsungpassautofill

echo Включение голосом
%~dp0adb shell pm uninstall --user 0 com.samsung.android.bixby.wakeup

echo Главный экран Samsung DeX
%~dp0adb shell pm uninstall --user 0 com.sec.android.app.desktoplauncher

echo Google Диск
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.docs

echo Диспетчер вашего телефона
%~dp0adb shell pm uninstall --user 0 com.microsoft.appmanager

echo Звукозапись
%~dp0adb shell pm uninstall --user 0 com.sec.android.app.voicenote

echo Карты
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.maps

echo Каталог живых обоев
%~dp0adb shell pm uninstall --user 0 com.android.wallpaper.livepicker

echo Клавиатура Microsoft SwiftKey
%~dp0adb shell pm uninstall --user 0 com.touchtype.swiftkey

echo Клавиатура Samsung
%~dp0adb shell pm uninstall --user 0 com.samsung.android.honeyboard

echo Люди
%~dp0adb shell pm uninstall --user 0 com.samsung.android.service.peoplestripe

echo Мои файлы
%~dp0adb shell pm uninstall --user 0 com.sec.android.app.myfiles

echo Погода
%~dp0adb shell pm uninstall --user 0 com.sec.android.daemonapp

echo Прямая расшифровка
%~dp0adb shell pm uninstall --user 0 com.google.audio.hearing.visualization.accessibility.scribe

echo Редактор AR-эмодзи
%~dp0adb shell pm uninstall --user 0 com.samsung.android.aremojieditor

echo Руководство пользователя
%~dp0adb shell pm uninstall --user 0 com.sec.android.widgetapp.webmanual

echo SIM-карта
%~dp0adb shell pm uninstall --user 0 com.android.stk

echo Служба Bixby
%~dp0adb shell pm uninstall --user 0 com.samsung.android.bixby.service

echo Советы
%~dp0adb shell pm uninstall --user 0 com.samsung.android.app.tips

echo Стикеры AR Emoji
%~dp0adb shell pm uninstall --user 0 com.sec.android.mimage.avatarstickers

echo Сценарии Bixby
%~dp0adb shell pm uninstall --user 0 com.samsung.android.app.routines

echo Установщик Kids
%~dp0adb shell pm uninstall --user 0 com.samsung.android.kidsinstaller

echo Яндекс
%~dp0adb shell pm uninstall --user 0 ru.yandex.searchplugin

%~dp0adb kill-server
echo.

RMDIR /S /Q %USERPROFILE%\.android
RMDIR /S /Q %USERPROFILE%\.dbus-keyrings
pause
