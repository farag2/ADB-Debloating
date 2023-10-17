cls
# Check whether all necessary files exist in the bin folder
$Files = @(
	"$PSScriptRoot\platform-tools\adb.exe",
	"$PSScriptRoot\JSON\Google.json",
	"$PSScriptRoot\JSON\Samsung.json",
	"$PSScriptRoot\JSON\Xiaomi.json"
)
if (($Files | Test-Path) -contains $false)
{
	Write-Warning -Message "Re-download archive and download ADB via Download_ADB.ps1"
	Start-Process -FilePath "https://github.com/farag2/ADB-Debloating"

	pause
	exit
}

<#
	.SYNOPSIS
	The "Show menu" function with the up/down arrow keys and enter key to make a selection

	.PARAMETER Menu
	Array of items to choose from

	.PARAMETER Default
	Default selected item in array

	.PARAMETER AddSkip
	Add localized extracted "Skip" string from shell32.dll

	.EXAMPLE
	Show-Menu -Menu $Items -Default 1

	.LINK
	https://qna.habr.com/answer?answer_id=1522379
#>
function Show-Menu
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		[array]
		$Menu,

		[Parameter(Mandatory = $true)]
		[int]
		$Default
	)

	# https://github.com/microsoft/terminal/issues/14992
	[System.Console]::BufferHeight += $Menu.Count
	$minY = [Console]::CursorTop
	$y = [Math]::Max([Math]::Min($Default, $Menu.Count), 0)

	do
	{
		[Console]::CursorTop = $minY
		[Console]::CursorLeft = 0
		$i = 0

		foreach ($item in $Menu)
		{
			if ($i -ne $y)
			{
				Write-Information -MessageData ('  {1}  ' -f ($i+1), $item) -InformationAction Continue
			}
			else
			{
				Write-Information -MessageData ('[ {1} ]' -f ($i+1), $item) -InformationAction Continue
			}

			$i++
		}

		$k = [Console]::ReadKey()

		switch ($k.Key)
		{
			"UpArrow"
			{
				if ($y -gt 0)
				{
					$y--
				}
			}
			"DownArrow"
			{
				if ($y -lt ($Menu.Count - 1))
				{
					$y++
				}
			}
			"Enter"
			{
				return $Menu[$y]
			}
		}
	}
	while ($k.Key -notin ([ConsoleKey]::Escape, [ConsoleKey]::Enter))
}

$File = Show-Menu -Menu @("Samsung", "Xiaomi", "Google") -Default 1

Write-Verbose -Message "Please wait..." -Verbose

$PackagesList = Get-Content -Path "$PSScriptRoot\JSON\$File.json" | ConvertFrom-Json
# Check if disabled packages exist, unless we cannot check if replace() method exists for them
if ($null -ne (& $PSScriptRoot\platform-tools\adb.exe shell pm list packages -d))
{
	$DisabledPackages = @((& $PSScriptRoot\platform-tools\adb.exe shell pm list packages -d).replace("package:", ""))
}

$Packages = @()
foreach ($Package in $PackagesList.Package)
{
	if ((@((& $PSScriptRoot\platform-tools\adb.exe shell cmd package list packages).replace("package:", "")) | Where-Object -FilterScript {$_ -eq $Package}) -or ($DisabledPackages -contains $Package))
	{
		$Packages += $PackagesList | Where-Object {$_.Package -eq $Package}
	}
}

Write-Warning -Message "Waiting your phone to be connected and allowed USB debugging"

& $PSScriptRoot\platform-tools\adb.exe wait-for-device

pause

Add-Type -AssemblyName PresentationCore, PresentationFramework

$CheckedPackages = New-Object -TypeName System.Collections.ArrayList($null)

#region XAML Markup
# The section defines the design of the upcoming dialog box
[xml]$XAML = @"
<Window
	xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
	xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
	Name="Window"
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
		<ScrollViewer Grid.Row="0">
		<StackPanel Name="PanelContainer"/>
		</ScrollViewer>
		<Button Name="ButtonUninstall" Grid.Row="2"/>
	</Grid>
</Window>
"@
#endregion XAML Markup

$Form = [Windows.Markup.XamlReader]::Load((New-Object -TypeName System.Xml.XmlNodeReader -ArgumentList $XAML))
$XAML.SelectNodes("//*[@*[contains(translate(name(.),'n','N'),'Name')]]") | ForEach-Object -Process {
	Set-Variable -Name ($_.Name) -Value $Form.FindName($_.Name)
}

$ButtonUninstall.Content = "Uninstall"
$Window.Title = "Bloatware ADB Uninstaller"
#endregion Variables

#region Functions
function CheckBoxClicked
{
	if ($Script:CheckedPackages.Contains($_.Source.Tag))
	{
		$Script:CheckedPackages.Remove($_.Source.Tag)
	}
	else
	{
		$Script:CheckedPackages.Add($_.Source.Tag) | Out-Null
	}

	$Script:ButtonUninstall.IsEnabled = $Script:CheckedPackages.Count -gt 0
}

function ButtonUninstallClicked
{
	$Form.Close()

	$Script:CheckedPackages | ForEach-Object -Process {
		$_ -split " " | ForEach-Object -Process {
			Write-Verbose -Message $_ -Verbose

			if ((@(& $PSScriptRoot\platform-tools\adb.exe shell pm uninstall --user 0 $_)) -contains "Failure [-1000]")
			{
				& $PSScriptRoot\platform-tools\adb.exe shell pm disable-user $_
			}
		}
	}
}
#endregion

foreach ($Package in $Packages)
{
	$Panel = New-Object -TypeName System.Windows.Controls.StackPanel
	$CheckBox = New-Object -TypeName System.Windows.Controls.CheckBox
	$TextBlock = New-Object -TypeName System.Windows.Controls.TextBlock
	$Panel.Orientation = "Horizontal"
	$CheckBox.Tag = $Package.Package
	$CheckBox.Add_Click({ CheckBoxClicked })
	$TextBlock.Text = $Package.Name
	$Panel.Children.Add($CheckBox) | Out-Null
	$Panel.Children.Add($TextBlock) | Out-Null
	$PanelContainer.Children.Add($Panel) | Out-Null
}

$ButtonUninstall.Add_Click({ ButtonUninstallClicked })
$Form.ShowDialog() | Out-Null

Start-Sleep -Seconds 3

Stop-Process -Name adb -Force -ErrorAction Ignore

Remove-Item -Path "$env:USERPROFILE\.android", "$env:USERPROFILE\dbus-keyrings" -Recurse -Force -ErrorAction Ignore

pause
