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
echo WPS Office
%~dp0adb shell pm uninstall --user 0 cn.wps.moffice_eng

echo Mi Doc Viewer (Powered by WPS)
%~dp0adb shell pm uninstall --user 0 cn.wps.xiaomi.abroad.lite

echo Aliexpress
%~dp0adb shell pm uninstall --user 0 com.alibaba.aliexpresshd

echo Aliexpress Ru
%~dp0adb shell pm uninstall --user 0 ru.aliexpress.buyer

echo Юла
%~dp0adb shell pm uninstall --user 0 com.allgoritm.youla

echo Bookmark Provider
%~dp0adb shell pm uninstall --user 0 com.android.bookmarkprovider

echo Browser Services
%~dp0adb shell pm uninstall --user 0 com.android.browser

echo Google Assistant
%~dp0adb shell pm uninstall --user 0 com.android.hotwordenrollment.xgoogle
%~dp0adb shell pm uninstall --user 0 com.android.hotwordenrollment.okgoogle

echo Chrome
%~dp0adb shell pm uninstall --user 0 com.android.chrome

echo Downloads
%~dp0adb shell pm uninstall --user 0 com.android.providers.downloads.ui

echo Sound recorder
%~dp0adb shell pm uninstall --user 0 com.android.soundrecorder

echo SIM Toolkit
%~dp0adb shell pm uninstall --user 0 com.android.stk

echo Live Wallpaper Picker
%~dp0adb shell pm uninstall --user 0 com.android.wallpaper.livepicker

echo Bouygues AppCloud
%~dp0adb shell pm uninstall --user 0 com.aura.oobe.bouygues

echo Booking.com
%~dp0adb shell pm uninstall --user 0 com.booking

echo Crazy Juicer
%~dp0adb shell pm uninstall --user 0 com.crazy.juicer.xm

echo Mi Remote
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

echo Emoji Keyboard
%~dp0adb shell pm uninstall --user 0 com.facemoji.lite.xiaomi

echo Google Drive
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.docs

echo Google Assistant
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.googleassistant

echo Google News
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.magazines

echo Maps
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.maps

echo Google Photos
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.photos

echo Google Podcasts
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.podcasts

echo Duo
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.tachyon

echo Device Health Services
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.turbo

echo Digital Wellbeing
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.wellbeing

echo Google Pay
:: %~dp0adb shell pm uninstall --user 0 com.google.android.apps.walletnfcrel

echo Gmail
%~dp0adb shell pm uninstall --user 0 com.google.android.gm

echo Google
%~dp0adb shell pm uninstall --user 0 com.google.android.googlequicksearchbox

echo Google Play Music
%~dp0adb shell pm uninstall --user 0 com.google.android.music

echo Google Files
:: %~dp0adb shell pm uninstall --user 0 com.google.android.apps.nbu

echo Google Play Games
%~dp0adb shell pm uninstall --user 0 com.google.android.play.games

echo Android Auto
:: %~dp0adb shell pm uninstall --user 0 com.google.android.projection.gearhead

echo Android One
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.subscriptions.red

echo Google TV
%~dp0adb shell pm uninstall --user 0 com.google.android.videos

echo Google Lens
%~dp0adb shell pm uninstall --user 0 com.google.ar.lens

echo Google Play Services for AR
%~dp0adb shell pm uninstall --user 0 com.google.ar.core

echo Lords Mobile
%~dp0adb shell pm uninstall --user 0 com.igg.android.lordsmobile

echo Kaspersky Internet Security
%~dp0adb shell pm uninstall --user 0 com.kms.free

echo Mi Browser Pro
%~dp0adb shell pm uninstall --user 0 com.mi.globalbrowser

echo Tile Fun
%~dp0adb shell pm uninstall --user 0 com.mintgames.triplecrush.tile.fun

echo Crazy Juicer
%~dp0adb shell pm uninstall --user 0 com.crazy.juicer.xm

echo Mi Wallpaper Carousel
%~dp0adb shell pm uninstall --user 0 com.miui.android.fashiongallery

echo File Manager
:: Becomes unable to install a firmware within the 3 dots
:: %~dp0adb shell pm uninstall --user 0 com.mi.android.globalFileexplorer

echo App Vault
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

echo HybridAccessory
%~dp0adb shell pm uninstall --user 0 com.miui.hybrid

echo MIUI Notes
%~dp0adb shell pm uninstall --user 0 com.miui.notes

echo Yellow Pages
%~dp0adb shell pm uninstall --user 0 com.miui.yellowpage

echo Analytics
%~dp0adb shell pm uninstall --user 0 com.miui.analytics

echo Compass
%~dp0adb shell pm uninstall --user 0 com.miui.compass

echo FM Radio
%~dp0adb shell pm uninstall --user 0 com.miui.fm

echo FM Radio Service
%~dp0adb shell pm uninstall --user 0 com.miui.fmservice

echo Personal Safety
%~dp0adb shell pm uninstall --user 0 com.google.android.apps.safetyhub

echo Services ^& Feedback
%~dp0adb shell pm uninstall --user 0 com.miui.miservice

echo ShareMe
%~dp0adb shell pm uninstall --user 0 com.miui.mishare.connectivity
%~dp0adb shell pm uninstall --user 0 com.xiaomi.midrop

echo msa
%~dp0adb shell pm uninstall --user 0 com.miui.msa.global

echo Mi Music
%~dp0adb shell pm uninstall --user 0 com.miui.player

echo Mi Video
:: Unable to uninstall on some devices
%~dp0adb shell pm uninstall --user 0 com.miui.videoplayer

echo PartnerNetflixActivation
%~dp0adb shell pm uninstall --user 0 com.netflix.partner.activation

echo Netflix
%~dp0adb shell pm uninstall --user 0 com.netflix.mediaclient

echo Opera
%~dp0adb shell pm uninstall --user 0 com.opera.browser
%~dp0adb shell pm uninstall --user 0 com.opera.preinstall

echo Qualcomm Voice Assist
%~dp0adb shell pm uninstall --user 0 com.quicinc.voice.activation

echo Spotify
%~dp0adb shell pm uninstall --user 0 com.spotify.music

echo Bubble Shooter And Friends
%~dp0adb shell pm uninstall --user 0 com.sukhavati.gotoplaying.bubble.BubbleShooter.mint

echo PUBG MOBILE Gift Box
%~dp0adb shell pm uninstall --user 0 com.tencent.igxiaomi

echo Joyose
%~dp0adb shell pm uninstall --user 0 com.xiaomi.joyose

echo Mi Scanner
:: Becomes unable to scan QR codes via Camera app
:: %~dp0adb shell pm uninstall --user 0 com.xiaomi.scanner

echo Xiaomi Games
%~dp0adb shell pm uninstall --user 0 com.xiaomi.glgm

echo Mi Picks
%~dp0adb shell pm uninstall --user 0 com.xiaomi.mipicks

echo Mi Coin
%~dp0adb shell pm uninstall --user 0 com.xiaomi.payment

echo Дзен
%~dp0adb shell pm uninstall --user 0 com.yandex.zen

echo TikTok
%~dp0adb shell pm uninstall --user 0 com.zhiliaoapp.musically

echo Яндекс Браузер
%~dp0adb shell pm uninstall --user 0 com.yandex.browser

echo ZenkitPartnerConfig
%~dp0adb shell pm uninstall --user 0 com.yandex.zenkitpartnerconfig

echo Яндекс Satellite
%~dp0adb shell pm uninstall --user 0 com.yandex.preinstallsatellite

echo ivi
%~dp0adb shell pm uninstall --user 0 ru.ivi.client

echo Яндекс
%~dp0adb shell pm uninstall --user 0 ru.yandex.searchplugin

echo Linkedin
%~dp0adb shell pm uninstall --user 0 com.linkedin.android

echo Amazon Shopping
%~dp0adb shell pm uninstall --user 0 com.amazon.mShop.android.shopping

echo Block Puzzle Guardian
%~dp0adb shell pm uninstall --user 0 com.block.puzzle.game.hippo.mi

echo Tile Fun
%~dp0adb shell pm uninstall --user 0 com.mintgames.triplecrush.tile.fun

echo Bubble Shooter With Friends
%~dp0adb shell pm uninstall --user 0 com.sukhavati.gotoplaying.bubble.BubbleShooter.mint

echo Jewels Blast
%~dp0adb shell pm uninstall --user 0 com.jewelsblast.ivygames.Adventure.free

echo Dust Settle
%~dp0adb shell pm uninstall --user 0 com.logame.eliminateintruder3d

echo State of Survival
%~dp0adb shell pm uninstall --user 0 com.kingsgroup.ss.xiaomi

%~dp0adb kill-server
echo.

taskkill /F /IM adb.exe /T 2>NUL

RMDIR /S /Q %USERPROFILE%\.android 2>NUL
RMDIR /S /Q %USERPROFILE%\.dbus-keyrings 2>NUL
pause
