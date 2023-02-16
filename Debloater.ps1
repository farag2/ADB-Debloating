#Requires -RunAsAdministrator
#Requires -Version 5.1

#region Preparations
$ErrorActionPreference = 'Stop'
[Console]::Title = 'ADB Debloater'
Remove-Module -Name Functions -ErrorAction SilentlyContinue
Import-Module -Name $PSScriptRoot\Functions.ps1
#endregion Preparations

