# Download SDK Platform Tools

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# https://developer.android.com/studio/releases/platform-tools
$Parameters = @{
	Uri             = "https://dl.google.com/android/repository/platform-tools-latest-windows.zip"
	OutFile         = "$PSScriptRoot\platform-tools.zip"
	UseBasicParsing = $true
	Verbose         = $true
}
Invoke-WebRequest @Parameters

$Parameters = @{
	Path            = "$PSScriptRoot\platform-tools.zip"
	DestinationPath = "$PSScriptRoot"
	Force           = $true
	Verbose         = $true
}
Expand-Archive @Parameters

Remove-Item -Path "$PSScriptRoot\platform-tools.zip" -Force

# [Environment]::SetEnvironmentVariable("ADB", "D:\adb.exe", "User")
# [Environment]::SetEnvironmentVariable("Fastboot", "D:\fastboot.exe", "User")
