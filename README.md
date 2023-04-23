# Debloat MIUI 14, One UI 5.1, Pixel Launcher via ADB

[telegram-news-badge]: https://img.shields.io/badge/Sophia%20News-Telegram-blue?style=flat&logo=Telegram
[telegram-news]: https://t.me/sophianews
[telegram-group]: https://t.me/sophia_chat
[telegram-group-badge]: https://img.shields.io/badge/Sophia%20Chat-Telegram-blue?style=flat&logo=Telegram

[![Telegram][telegram-news-badge]][telegram-news] [![Telegram][telegram-group-badge]][telegram-group]

[![ko-fi](https://www.ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/Q5Q51QUJC)

<a href="https://yoomoney.ru/to/4100116615568835"><img src="https://yoomoney.ru/i/shop/iomoney_logo_color_example.png" width=220px height=46px></a>

## Get apps packages list

```cmd
adb.exe shell pm list packages -f > D:\packages.txt
```

## Copy folder to local drive

```cmd
# /storage/emulated/0
# /sdcard

# Check the whole filesystem
adb shell ls /data

adb pull /storage/3039-3538/dcim/camera D:\folder
adb pull sdcard/DCIM/Camera D:\folder
```

## Screenshot

![image](https://user-images.githubusercontent.com/10544660/233859224-6bb2e199-3833-4238-a670-aa98960e3801.png)

## How-to

* Connect phone to PC via USB cable;
* Enable USB debugging in your phone OS;
* Download and expand latest release archive;
* Download ADB via `Download_ADB.ps1`;
* Run `Function.ps1`.

## Links

* [Google USB Driver](https://developer.android.com/studio/run/win-usb)
  * [Official all OEMs drivers](https://developer.android.com/studio/run/oem-usb#Drivers)
* [Download ADB](https://developer.android.com/studio/releases/platform-tools)
* [App Inspector](https://play.google.com/store/apps/details?id=com.ubqsoft.sec01)
* [ADB AppControl](https://4pda.to/forum/index.php?showtopic=993643)
* [ReVanced](https://github.com/revanced)
* [My ReVanced Builder](https://github.com/farag2/ReVanced_Builder)

## Ask a question on

* MIUI
  * [Mi 11T Pro](https://4pda.to/forum/index.php?showtopic=1032499&st=2320#entry112088380)
  * [Mi 10T](https://4pda.to/forum/index.php?s=&showtopic=1005145&view=findpost&p=100967182)
  * [Mi 9T](https://4pda.to/forum/index.php?s=&showtopic=955101&view=findpost&p=93561572)
* One UI
  * [Galaxy S20](https://4pda.to/forum/index.php?s=&showtopic=953111&view=findpost&p=97533733)
