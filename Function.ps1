if (-not (Test-Path -Path $PSScriptRoot\adb.exe))
{
	Write-Warning -Message "Place adb.exe to the folder root"
	Start-Process -FilePath "https://github.com/farag2/ADB-Debloating/blob/master/Download_ADB.ps1"

	pause
	exit
}

do
{
	$Proceed = Read-Host -Prompt "Type your device vendor. `"Xiaomi`", `"Google`", or `"Samsung`""
	if ($Proceed -eq "Xiaomi")
	{
		$File = "Xiaomi"
	}

	if ($Proceed -eq "Google")
	{
		$File = "Google"
	}

	if ($Proceed -eq "Samsung")
	{
		$File = "Samsung"
	}
}
until (($Proceed -eq "Xiaomi") -or ($Proceed -eq "Google") -or ($Proceed -eq "Samsung"))

if (Test-Path -Path "$PSScriptRoot\JSONs\$File.json")
{
	$Packages = Get-Content -Path "$PSScriptRoot\JSONs\$File.json" | ConvertFrom-Json
}
else
{
	Write-Warning -Message "$PSScriptRoot\JSONs\$File.json doesn't exist"
	Start-Process -FilePath "https://github.com/farag2/ADB-Debloating"

	pause
	exit
}

& $PSScriptRoot\adb.exe wait-for-device
pause

Add-Type -AssemblyName PresentationCore, PresentationFramework

$CheckedPackages = New-Object System.Collections.ArrayList($null)

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
			<Button Name="ButtonUnistall" Grid.Row="2"/>
		</Grid>
	</Window>
"@
#endregion XAML Markup

$Form = [Windows.Markup.XamlReader]::Load((New-Object -TypeName System.Xml.XmlNodeReader -ArgumentList $XAML))
$XAML.SelectNodes("//*[@*[contains(translate(name(.),'n','N'),'Name')]]") | ForEach-Object -Process {
	Set-Variable -Name ($_.Name) -Value $Form.FindName($_.Name)
}

$ButtonUnistall.Content = "Uninstall"
$Window.Title = "Bloatware ADB Uninstaller"
#endregion Variables

#region Functions
function CheckBoxClicked
{
	if ($Global:CheckedPackages.Contains($_.Source.Tag))
	{
		$Global:CheckedPackages.Remove($_.Source.Tag)
	}
	else
	{
		$Global:CheckedPackages.Add($_.Source.Tag) | Out-Null
	}

	$Global:ButtonUnistall.IsEnabled = $Global:CheckedPackages.Count -gt 0
}

function ButtonUnistallClicked
{
	$Form.Close()

	$Global:CheckedPackages | ForEach-Object -Process {
		$_ -split " " | ForEach-Object -Process {
			if (@("com.android.soundrecorder", "com.miui.notes", "com.miui.notes", "com.miui.compass", "com.miui.compass") -contains $_)
			{
				if (& $PSScriptRoot\adb.exe shell pm list packages $_)
				{
					& $PSScriptRoot\adb.exe shell pm disable-user $_
				}
			}
			else
			{
				& $PSScriptRoot\adb.exe shell pm uninstall --user 0 $_
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

$ButtonUnistall.Add_Click({ ButtonUnistallClicked })
$Form.ShowDialog() | Out-Null

Stop-Process -Name adb.exe -Force -ErrorAction Ignore

Remove-Item -Path "$env:USERPROFILE\.android", "$env:USERPROFILE\1.txt", "$env:USERPROFILE\dbus-keyrings" -Recurse -Force -ErrorAction Ignore
