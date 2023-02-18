#Requires -RunAsAdministrator
#Requires -Version 5.1

#region Preparations
$ErrorActionPreference = 'Stop'
[Console]::Title = 'ADB Debloater'
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
            Write-Host "Your device is successfully connected." -ForegroundColor Green
        }
        { $_ -eq "unauthorized" } {
            Write-Host "Your device is unauthorized." -ForegroundColor Red
            Write-Host 'Please select checkbox "Always allow from this computer" and press "Allow".'
            Start-Sleep -Seconds 10
        }
        { $_ -eq "disconnected" } {
            Write-Host "Your device isn't connected or USB debbuging isn't on." -ForegroundColor Red
            Write-Host "Please connect your device and turn on USB debbuging."
            Start-Sleep -Seconds 10
        }
        { $_ -eq "multiple" } {
            Write-Host "You have connected multiple devices." -ForegroundColor Red
            Write-Host "Please disconnect unnecessary ones."
            Start-Sleep -Seconds 10
        }
    }
} until ($connectionStatus -eq "connected")

Stop-Adb