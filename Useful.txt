# ADB
New-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Control\usbflags\18D1D00D0100 -Name SkipContainerIdQuery -PropertyType Binary -Value ([byte[]](01, 00, 00, 00)) -Force
New-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Control\usbflags\18D1D00D0100 -Name SkipBOSDescriptorQuery -PropertyType Binary -Value ([byte[]](01, 00, 00, 00)) -Force
New-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Control\usbflags\18D1D00D0100 -Name osvc -PropertyType Binary -Value ([byte[]](00, 00)) -Force
