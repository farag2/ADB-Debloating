# Download SDK Platform Tools

Add-Type -AssemblyName System.Windows.Forms
$FolderBrowserDialog = New-Object -TypeName System.Windows.Forms.FolderBrowserDialog
# $FolderBrowserDialog.RootFolder = "MyComputer"
# Force move the open file dialog to the foreground
$Focus = New-Object -TypeName System.Windows.Forms.Form -Property @{TopMost = $true}
$FolderBrowserDialog.ShowDialog()

if ($FolderBrowserDialog.SelectedPath)
{
	[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

	# https://developer.android.com/studio/releases/platform-tools
	$Parameters = @{
		Uri             = "https://dl.google.com/android/repository/platform-tools-latest-windows.zip"
		OutFile         = "$($FolderBrowserDialog.SelectedPath)\platform-tools.zip"
		UseBasicParsing = $true
		Verbose         = $true
	}
	Invoke-WebRequest @Parameters

	$Parameters = @{
		Path            = "$($FolderBrowserDialog.SelectedPath)\platform-tools.zip"
		DestinationPath = "$($FolderBrowserDialog.SelectedPath)"
		Force           = $true
		Verbose         = $true
	}
	Expand-Archive @Parameters

	Remove-Item -Path "$($FolderBrowserDialog.SelectedPath)\platform-tools.zip" -Force

	# [Environment]::SetEnvironmentVariable("ADB", "$($FolderBrowserDialog.SelectedPath)\platform-tools\adb.exe", "User")
	# [Environment]::SetEnvironmentVariable("Fastboot", "$($FolderBrowserDialog.SelectedPath)\platform-tools\fastboot.exe", "User")
}
