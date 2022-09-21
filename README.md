# Debloat MIUI 13, One UI 4.1, Pixel Launcher via ADB

[![ko-fi](https://www.ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/Q5Q51QUJC)

<a href="https://yoomoney.ru/to/4100116615568835"><img src="https://yoomoney.ru/i/shop/iomoney_logo_color_example.png" width=220px height=46px></a>

## Get apps packages list

```cmd
adb shell pm list packages -f > %CD%\packages.txt
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

## How-to

* Downloaded ADB;
* Place the necessary .cmd script into the downloaded ADB folder;
* Customize the .cmd file;
* Run.

## Note

Comment out/uncomment packages names

## Links

* [Google USB Driver](https://developer.android.com/studio/run/win-usb)
  * [Official all OEMs drivers](https://developer.android.com/studio/run/oem-usb#Drivers)
* [Download ADB](https://developer.android.com/studio/releases/platform-tools)
* [App Inspector](https://play.google.com/store/apps/details?id=com.ubqsoft.sec01)
* [ADB AppControl](https://4pda.ru/forum/index.php?showtopic=993643)
* [ReVanced](https://github.com/revanced)
* [My ReVanced Builder](https://github.com/farag2/ReVanced_Builder)

## Ask a question on

* MIUI
  * [Mi 11T Pro](https://4pda.to/forum/index.php?showtopic=1032499&st=2320#entry112088380)
  * [Mi 10T](https://4pda.ru/forum/index.php?s=&showtopic=1005145&view=findpost&p=100967182)
  * [Mi 9T](https://4pda.ru/forum/index.php?s=&showtopic=955101&view=findpost&p=93561572)
* One UI
  * [Galaxy S20](https://4pda.ru/forum/index.php?s=&showtopic=953111&view=findpost&p=97533733)
