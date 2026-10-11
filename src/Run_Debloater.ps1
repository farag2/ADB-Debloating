#Requires -Version 5.1

Clear-Host

$ADB = "$PSScriptRoot\platform-tools\adb.exe"

# Check whether all necessary files exist
if (-not ((Test-Path -Path $ADB) -and (Test-Path -Path "$PSScriptRoot\Apps.json")))
{
	Write-Warning -Message "Re-download archive and download ADB via Download_ADB.ps1"
	Start-Process -FilePath "https://github.com/farag2/ADB-Debloating"

	pause
	exit
}

try
{
	$Apps = Get-Content -Path "$PSScriptRoot\Apps.json" -Raw -Encoding UTF8 | ConvertFrom-Json -ErrorAction Stop
}
catch
{
	Write-Warning -Message "$PSScriptRoot\Apps.json is not valid"

	pause
	exit
}

# Get connected phones
$Transports = @(& $ADB devices | Where-Object -FilterScript {$_.EndsWith("`tdevice")} | ForEach-Object -Process {$_.Split("`t")[0]})
while ($Transports.Count -eq 0)
{
	Write-Verbose -Message "Enable Wi-Fi debugging page and open page to connect via code" -Verbose
	pause

	$PairingIPAddress = Read-Host -Prompt "Type IP Address"
	if (-not $PairingIPAddress)
	{
		& $ADB kill-server
		exit
	}

	try
	{
		# Cast throws an exception if value is not valid
		[ipaddress]$PairingIPAddress | Out-Null
	}
	catch
	{
		Write-Warning -Message "$PairingIPAddress is not a valid IP address"
		continue
	}

	$PairingPort = Read-Host -Prompt "Type port"
	if (-not $PairingPort)
	{
		& $ADB kill-server
		exit
	}

	$PairingCode = Read-Host -Prompt "Type pairing temp code"
	if (-not $PairingCode)
	{
		& $ADB kill-server
		exit
	}

	# Pairing
	& $ADB pair "${PairingIPAddress}:$PairingPort" $PairingCode

	$Port = Read-Host -Prompt "Type port from main page"
	if (-not $Port)
	{
		& $ADB kill-server
		exit
	}

	# Connecting
	& $ADB connect "${PairingIPAddress}:$Port"

	$Transports = @(& $ADB devices | Where-Object -FilterScript {$_.EndsWith("`tdevice")} | ForEach-Object -Process {$_.Split("`t")[0]})
}

# The same phone may be listed twice: connected via "adb connect" and auto-connected via mDNS after "adb pair"
# All next adb calls use the first transport of the phone explicitly
$Transport = $Transports[0]

Write-Verbose -Message "" -Verbose
Write-Verbose -Message "Please wait..." -Verbose

# Get installed for user 0 and enabled packages with a single call. "-e" has no long form and means "enabled only"
# Already uninstalled for user 0 and disabled packages are not listed
$EnabledPackages = @(& $ADB -s $Transport shell cmd package list packages -e --user 0 | ForEach-Object -Process {$_.Replace("package:", "").Trim()})
if ($EnabledPackages.Count -eq 0)
{
	Write-Warning -Message "Turn wireless debugging off and on, then run script again"
	& $ADB kill-server

	pause
	exit
}

# Remove duplicated packages and leave only installed ones, sorted by app's name
$Packages = $Apps | Sort-Object -Property Package -Unique | Where-Object -FilterScript {$EnabledPackages -contains $_.Package} | Sort-Object -Property Name
if (-not $Packages)
{
	Write-Verbose -Message "No apps from Apps.json found on device" -Verbose
	& $ADB kill-server

	pause
	exit
}

Add-Type -AssemblyName PresentationCore, PresentationFramework

[xml]$XAML = @"
<Window
	xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
	xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
	Name="Window"
	Title="Bloatware ADB Uninstaller"
	MinHeight="460" MinWidth="350"
	SizeToContent="Width" WindowStartupLocation="CenterScreen"
	TextOptions.TextFormattingMode="Display" SnapsToDevicePixels="True"
	FontFamily="Candara" FontSize="16" ShowInTaskbar="True"
	Background="#F1F1F1" Foreground="#262626">
	<Window.Resources>
		<Style TargetType="CheckBox">
			<Setter Property="VerticalAlignment" Value="Center"/>
			<Setter Property="Margin" Value="10"/>
		</Style>
		<Style TargetType="TextBlock">
			<Setter Property="VerticalAlignment" Value="Center"/>
			<Setter Property="Margin" Value="0, 0, 0, 2"/>
		</Style>
		<Style TargetType="Button">
			<Setter Property="Margin" Value="20"/>
			<Setter Property="Padding" Value="10"/>
			<Setter Property="IsEnabled" Value="False"/>
		</Style>
	</Window.Resources>
	<Grid>
		<Grid.RowDefinitions>
			<RowDefinition Height="*"/>
			<RowDefinition Height="Auto"/>
		</Grid.RowDefinitions>
		<ScrollViewer Grid.Row="0" VerticalScrollBarVisibility="Auto">
			<StackPanel Name="PanelContainer"/>
		</ScrollViewer>
		<Button Name="ButtonUninstall" Grid.Row="1" Content="Uninstall"/>
	</Grid>
</Window>
"@

$Form = [Windows.Markup.XamlReader]::Load((New-Object -TypeName System.Xml.XmlNodeReader -ArgumentList $XAML))
$XAML.SelectNodes("//*[@Name]") | ForEach-Object -Process {
	Set-Variable -Name $_.Name -Value $Form.FindName($_.Name)
}

$CheckBoxes = @(
	foreach ($Package in $Packages)
	{
		$Panel = New-Object -TypeName System.Windows.Controls.StackPanel
		$Panel.Orientation = "Horizontal"

		$CheckBox = New-Object -TypeName System.Windows.Controls.CheckBox
		$CheckBox.Tag = $Package.Package
		$CheckBox.Add_Click({
			$Script:ButtonUninstall.IsEnabled = [bool]($Script:CheckBoxes | Where-Object -FilterScript {$_.IsChecked})
		})

		$TextBlock = New-Object -TypeName System.Windows.Controls.TextBlock
		$TextBlock.Text = $Package.Name

		$Panel.Children.Add($CheckBox) | Out-Null
		$Panel.Children.Add($TextBlock) | Out-Null
		$PanelContainer.Children.Add($Panel) | Out-Null

		$CheckBox
	}
)

# DialogResult closes window and makes ShowDialog() return $true. Closing window via X returns $false
$ButtonUninstall.Add_Click({
	$Script:Form.DialogResult = $true
})

if ($Form.ShowDialog())
{
	$CheckedPackages = $CheckBoxes | Where-Object -FilterScript {$_.IsChecked} | ForEach-Object -Process {$_.Tag}

	foreach ($Package in $CheckedPackages)
	{
		Write-Verbose -Message $Package -Verbose

		# Output may contain "Failure [DELETE_FAILED_INTERNAL_ERROR]", "Failure [-1000]", "Failure [only root can delete system app for a particular user]"
		$Output = (& $ADB -s $Transport shell "cmd package uninstall --user 0 $Package 2>&1") -join " "
		if ($Output.Contains("Success"))
		{
			continue
		}

		Write-Warning -Message "$Package wasn't uninstalled. Trying to disable..."

		# Output is "Package <name> new state: disabled-user" on success
		$Output = (& $ADB -s $Transport shell "cmd package disable-user --user 0 $Package 2>&1") -join " "
		if ($Output.Contains("disabled-user"))
		{
			Write-Verbose -Message "$Package disabled" -Verbose
		}
		else
		{
			Write-Warning -Message "$Package can't be disabled: firmware protects it"
		}
	}
}

& $ADB kill-server

# %USERPROFILE%\.android is kept: it stores pairing key, so next time only IP address and port are needed
Remove-Item -Path "$env:USERPROFILE\dbus-keyrings" -Recurse -Force -ErrorAction Ignore

pause
