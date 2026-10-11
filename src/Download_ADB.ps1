# Download SDK Platform Tools
# https://developer.android.com/tools/releases/platform-tools

if ($PSVersionTable.PSVersion.Major -eq 5)
{
	[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

	# Progress bar can significantly impact cmdlet performance
	# https://github.com/PowerShell/PowerShell/issues/2138
	$ProgressPreference = "SilentlyContinue"
}

# Running adb.exe locks files in the platform-tools folder and Expand-Archive fails to overwrite them
Stop-Process -Name adb -Force -ErrorAction Ignore

try
{
	$Parameters = @{
		Uri             = "https://dl.google.com/android/repository/platform-tools-latest-windows.zip"
		OutFile         = "$PSScriptRoot\platform-tools.zip"
		UseBasicParsing = $true
		Verbose         = $true
		ErrorAction     = "Stop"
	}
	Invoke-WebRequest @Parameters
}
catch
{
	Write-Warning -Message "Unable to download SDK Platform Tools: $($_.Exception.Message)"
	Remove-Item -Path "$PSScriptRoot\platform-tools.zip" -Force -ErrorAction Ignore

	pause
	exit
}

# Remove previous version so no outdated files remain
Remove-Item -Path "$PSScriptRoot\platform-tools" -Recurse -Force -ErrorAction Ignore

$Parameters = @{
	Path            = "$PSScriptRoot\platform-tools.zip"
	DestinationPath = $PSScriptRoot
	Force           = $true
	Verbose         = $true
}
Expand-Archive @Parameters

Remove-Item -Path "$PSScriptRoot\platform-tools.zip" -Force
