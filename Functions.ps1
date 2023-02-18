#Requires -RunAsAdministrator
#Requires -Version 5.1

function Get-PlatformTools {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

    $Parameters = @{
        Uri             = "https://dl.google.com/android/repository/platform-tools-latest-windows.zip"
        OutFile         = "$PSScriptRoot\platform-tools.zip"
        UseBasicParsing = $true
        Verbose         = $true
    }
    Invoke-WebRequest @Parameters

    $Parameters = @{
        Path            = "$PSScriptRoot\platform-tools.zip"
        DestinationPath = $PSScriptRoot
        Force           = $true
        Verbose         = $true
    }
    Expand-Archive @Parameters

    Remove-Item -Path "$PSScriptRoot\platform-tools.zip" -Force
}

function Start-Adb {
    $adb = "$PSScriptRoot\platform-tools\adb.exe"
    .$adb start-server
}

function Stop-Adb {
    .$adb kill-server
}

function Test-AdbConnection {
    $devices = .$adb devices
    if ($devices.Length -gt 3) {
        return "multiple"
    }
    switch ($devices[1]) {
        { $PSItem -match "device" } { return "connected" }
        { $PSItem -match "unauthorized" } { return "unauthorized" }
        { $PSItem -eq "" } { return "disconnected" }
    }
}