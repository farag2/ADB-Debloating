#Requires -RunAsAdministrator
#Requires -Version 5.1

#region Preparations
$ErrorActionPreference = "Stop"
[Console]::Title = "ADB Debloater"
Remove-Module -Name Functions -ErrorAction SilentlyContinue
Import-Module -Name $PSScriptRoot\Functions.ps1
#endregion Preparations

Get-PlatformTools

Start-Adb

do {
    $connectionStatus = Test-AdbConnection
    Clear-Host
    switch ($connectionStatus) {
        { $_ -eq "connected" } {
            Write-Host -Object "Your device is successfully connected." -ForegroundColor Green
        }
        { $_ -eq "unauthorized" } {
            Write-Host -Object "Your device is unauthorized." -ForegroundColor Red
            Write-Host -Object 'Please select checkbox "Always allow from this computer" and press "Allow".'
            Wait-Retry -Seconds 10
        }
        { $_ -eq "disconnected" } {
            Write-Host -Object "Your device isn't connected or USB debbuging isn't on." -ForegroundColor Red
            Write-Host -Object "Please connect your device and turn on USB debbuging."
            Wait-Retry -Seconds 10
        }
        { $_ -eq "multiple" } {
            Write-Host -Object "You have connected multiple devices." -ForegroundColor Red
            Write-Host -Object "Please disconnect unnecessary ones."
            Wait-Retry -Seconds 10
        }
    }
} until ($connectionStatus -eq "connected")

$Parameters = @{
    Packages = Get-InstalledPackages
    List     = Get-Content -Path $PSScriptRoot\Uninstall-List.json -Raw | ConvertFrom-Json
}
Get-PackagesToUninstall @Parameters

Stop-Adb