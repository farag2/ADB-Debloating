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