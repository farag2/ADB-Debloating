Clear-Host

if (-not (Test-Path -Path $PSScriptRoot\adb.exe))
{
	Write-Warning -Message "Download ADB"
	Start-Process -FilePath "https://github.com/farag2/ADB-Debloating"
	pause
	exit
}

do
{
	$Proceed = Read-Host -Prompt "Uninstall MIUI apps?`nType `"amen`" to proceed"
	if ($Proceed -ne "amen")
	{
		continue
	}
}
until ($Proceed -eq "amen")

& $PSScriptRoot\adb.exe wait-for-device
pause

Write-Warning -Message "WPS Office"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 cn.wps.moffice_eng

Write-Warning -Message "Mi Doc Viewer (Powered by WPS)"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 cn.wps.xiaomi.abroad.lite

Write-Warning -Message Aliexpress
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.alibaba.aliexpresshd

Write-Warning -Message Юла
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.allgoritm.youla

Write-Warning -Message "Amazon Shopping"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.amazon.mShop.android.shopping

Write-Warning -Message "Bookmark Provider"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.android.bookmarkprovider

Write-Warning -Message "Browser Services"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.android.browser

Write-Warning -Message "Google Assistant"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.android.hotwordenrollment.xgoogle
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.android.hotwordenrollment.okgoogle

Write-Warning -Message Chrome
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.android.chrome

Write-Warning -Message Downloads
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.android.providers.downloads.ui

Write-Warning -Message "Sound recorder"
# Unable to uninstall
if (& $PSScriptRoot\adb.exe shell pm list packages com.android.soundrecorder)
{
	& $PSScriptRoot\adb.exe shell pm disable-user com.android.soundrecorder
}

Write-Warning -Message "SIM Toolkit"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.android.stk

Write-Warning -Message "Live Wallpaper Picker"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.android.wallpaper.livepicker

Write-Warning -Message "Bouygues AppCloud"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.aura.oobe.bouygues

Write-Warning -Message "Block Puzzle Guardian"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.block.puzzle.game.hippo.mi

Write-Warning -Message Booking.com
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.booking

Write-Warning -Message "Crazy Juicer"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.crazy.juicer.xm

Write-Warning -Message "Mi Remote"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.duokan.phone.remotecontroller

Write-Warning -Message "eBay Partner Attribution"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.ebay.carrier

Write-Warning -Message eBay
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.ebay.mobile

Write-Warning -Message YouTube
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.google.android.youtube

Write-Warning -Message "YouTube Music"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.google.android.apps.youtube.music

Write-Warning -Message "Android Accessibility Suite"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.google.android.marvin.talkback

Write-Warning -Message Facebook
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.facebook.katana
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.facebook.system
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.facebook.appmanager
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.facebook.services

Write-Warning -Message "Emoji Keyboard"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.facemoji.lite.xiaomi
# Unable to uninstall
& $PSScriptRoot\adb.exe shell pm disable-user com.preff.kb.xm

Write-Warning -Message "Jewels Blast"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.jewelsblast.ivygames.Adventure.free

Write-Warning -Message "Google Drive"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.google.android.apps.docs

Write-Warning -Message "Google Assistant"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.google.android.apps.googleassistant

Write-Warning -Message "Google News"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.google.android.apps.magazines

Write-Warning -Message Maps
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.google.android.apps.maps

Write-Warning -Message "Google Photos"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.google.android.apps.photos

Write-Warning -Message "Google Podcasts"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.google.android.apps.podcasts

Write-Warning -Message Duo
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.google.android.apps.tachyon

Write-Warning -Message "Device Health Services"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.google.android.apps.turbo

Write-Warning -Message "Digital Wellbeing"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.google.android.apps.wellbeing

Write-Warning -Message "Google Pay"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.google.android.apps.walletnfcrel

Write-Warning -Message "Google Find My Device"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.google.android.apps.adm

Write-Warning -Message Gmail
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.google.android.gm

Write-Warning -Message Google
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.google.android.googlequicksearchbox

Write-Warning -Message "Google Play Music"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.google.android.music

Write-Warning -Message "Google Files"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.google.android.apps.nbu.files

Write-Warning -Message "Google Play Games"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.google.android.play.games

Write-Warning -Message "Android Auto"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.google.android.projection.gearhead

Write-Warning -Message "Android One"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.google.android.apps.subscriptions.red

Write-Warning -Message "Google TV"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.google.android.videos

Write-Warning -Message "Google Lens"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.google.ar.lens

Write-Warning -Message "Google Play Services for AR"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.google.ar.core

Write-Warning -Message "Lords Mobile"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.igg.android.lordsmobile

Write-Warning -Message "State of Survival"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.kingsgroup.ss.xiaomi

Write-Warning -Message "Kaspersky Internet Security"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.kms.free

Write-Warning -Message Linkedin
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.linkedin.android

Write-Warning -Message "Dust Settle"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.logame.eliminateintruder3d

Write-Warning -Message "App Vault"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.mi.globalminusscreen
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.mi.android.globalminusscreen

Write-Warning -Message "Tile Fun"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.mintgames.triplecrush.tile.fun

Write-Warning -Message "Mi Browser Pro"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.mi.globalbrowser

Write-Warning -Message "Tile Fun"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.mintgames.triplecrush.tile.fun

Write-Warning -Message "Mi Wallpaper Carousel"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.miui.android.fashiongallery

Write-Warning -Message "Mi Credit"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.micredit.in

Write-Warning -Message "Mi Community"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.mi.global.bbs

Write-Warning -Message "Mi Store"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.mi.global.shop

Write-Warning -Message MiDrive
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.miui.newmidrive

Write-Warning -Message "Mi Mover"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.miui.huanji

Write-Warning -Message HybridAccessory
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.miui.hybrid

Write-Warning -Message "MIUI Notes"
# Unable to uninstall
if (& $PSScriptRoot\adb.exe shell pm list packages com.miui.notes)
{
	& $PSScriptRoot\adb.exe shell pm disable-user com.miui.notes
}

Write-Warning -Message "Yellow Pages"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.miui.yellowpage

Write-Warning -Message Analytics
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.miui.analytics

Write-Warning -Message Compass
# Unable to uninstall
if (& $PSScriptRoot\adb.exe shell pm list packages com.miui.compass)
{
	& $PSScriptRoot\adb.exe shell pm disable-user com.miui.compass
}

Write-Warning -Message "FM Radio"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.miui.fm

Write-Warning -Message "FM Radio Service"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.miui.fmservice

Write-Warning -Message "Personal Safety"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.google.android.apps.safetyhub

Write-Warning -Message "Services & Feedback"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.miui.miservice

Write-Warning -Message ShareMe
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.miui.mishare.connectivity
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.xiaomi.midrop

Write-Warning -Message msa
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.miui.msa.global

Write-Warning -Message "Mi Music"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.miui.player

Write-Warning -Message "Mi Video"
# Unable to uninstall
& $PSScriptRoot\adb.exe shell pm disable-user com.miui.videoplayer

Write-Warning -Message "Mobile Legends: Bang Bang"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.mobilelegends.mi

Write-Warning -Message PartnerNetflixActivation
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.netflix.partner.activation

Write-Warning -Message Netflix
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.netflix.mediaclient

Write-Warning -Message Opera
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.opera.browser
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.opera.preinstall

Write-Warning -Message "Qualcomm Voice Assist"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.quicinc.voice.activation

#Write-Warning -Message Spotify
#& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.spotify.music

Write-Warning -Message "Bubble Shooter And Friends"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.sukhavati.gotoplaying.bubble.BubbleShooter.mint

Write-Warning -Message "PUBG MOBILE Gift Box"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.tencent.igxiaomi

Write-Warning -Message Joyose
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.xiaomi.joyose

Write-Warning -Message "Xiaomi Games"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.xiaomi.glgm

Write-Warning -Message "Mi Picks"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.xiaomi.mipicks

Write-Warning -Message "Mi Coin"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.xiaomi.payment

Write-Warning -Message Дзен
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.yandex.zen

Write-Warning -Message "Яндекс Браузер"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.yandex.browser

Write-Warning -Message "Яндекс Satellite"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.yandex.preinstallsatellite

Write-Warning -Message ZenkitPartnerConfig
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.yandex.zenkitpartnerconfig

Write-Warning -Message TikTok
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 com.zhiliaoapp.musically

Write-Warning -Message "Aliexpress Ru"
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 ru.aliexpress.buyer

Write-Warning -Message ivi
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 ru.ivi.client

Write-Warning -Message Ozon
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 ru.ozon.app.android

Write-Warning -Message RuStore
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 ru.vk.store

Write-Warning -Message Яндекс
& $PSScriptRoot\adb.exe shell pm uninstall --user 0 ru.yandex.searchplugin

& $PSScriptRoot\adb.exe kill-server

Stop-Process -Name adb.exe -Force -ErrorAction Ignore

Remove-Item -Path "$env:USERPROFILE\.android", "$env:USERPROFILE\dbus-keyrings" -Recurse -Force -ErrorAction Ignore

pause
