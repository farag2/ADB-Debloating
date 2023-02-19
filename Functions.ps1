#Requires -RunAsAdministrator
#Requires -Version 5.1

function Get-PlatformTools {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

    $Parameters = @{
        Uri             = "https://dl.google.com/android/repository/platform-tools-latest-windows.zip"
        OutFile         = "$PSScriptRoot\platform-tools.zip"
        UseBasicParsing = $true
    }
    Invoke-WebRequest @Parameters

    $Parameters = @{
        Path            = "$PSScriptRoot\platform-tools.zip"
        DestinationPath = $PSScriptRoot
        Force           = $true
    }
    Expand-Archive @Parameters

    Remove-Item -Path "$PSScriptRoot\platform-tools.zip" -Force
}

function Start-Adb {
    $Env:adb = "$PSScriptRoot\platform-tools\adb.exe"
    .$Env:adb start-server
}

function Stop-Adb {
    .$Env:adb kill-server
}

function Test-AdbConnection {
    $devices = .$Env:adb devices
    if ($devices.Length -gt 3) {
        return "multiple"
    }
    switch ($devices[1]) {
        { $PSItem -match "device" } { return "connected" }
        { $PSItem -match "unauthorized" } { return "unauthorized" }
        { $PSItem -eq "" } { return "disconnected" }
    }
}

function Get-InstalledPackages {
    $packages = @()
    .$Env:adb shell pm list packages | ForEach-Object {
        $packages += $PSItem -replace ("package:", "")
    }
    return $packages
}

function Wait-Retry {
    param (
        [Parameter(Mandatory)]
        [ValidateScript({ $_ -gt 0 })]
        [int]$Seconds
    )
    Write-Host -Object "Retry after $seconds seconds..."
    for ($i = 0; $i -lt $seconds; $i++) {
        $Parameters = @{
            Activity        = "Waiting..."
            Status          = "Seconds remaining:$($seconds-$i)"
            PercentComplete = $([int]$i / $seconds * 100)
        }
        # PowerShell displays 0% as 100%
        if ($Parameters.PercentComplete -eq 0) {
            $Parameters.PercentComplete = 1
        }
        Write-Progress @Parameters
        Start-Sleep -Seconds 1
    }
}

function Get-PackagesToUninstall {
    param (
        [Parameter(Mandatory)]
        [array]$Packages,

        [Parameter(Mandatory)]
        [array]$List
    )
    [System.Collections.ArrayList]$packagesToUninstall = @()
    foreach ($app in $List) {
        $Packages | ForEach-Object {
            if ($PSItem -in $app.Package) {
                $packagesToUninstall += @{
                    Name    = $app.Name
                    Package = [System.Collections.ArrayList]@($PSItem)
                }
            }
        }
    }

    # Merge multiple packages from one app into one hashtable
    for ($i = 0; $i -lt ($packagesToUninstall.Count - 1); $i++) {
        for ($j = $i++; $j -lt ($packagesToUninstall.Count - 1); $j++) {
            if ($packagesToUninstall[$i].Name -eq $packagesToUninstall[$j].Name) {
                $packagesToUninstall[$i].Package.Add($packagesToUninstall[$j].Package)
                $packagesToUninstall.RemoveAt($j)
            }
        }
    }

    return $packagesToUninstall
}