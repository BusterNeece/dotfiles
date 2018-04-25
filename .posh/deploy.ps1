# Make sure we're in a reasonable execution policy
if((Get-ExecutionPolicy) -ne 'Unrestricted')
{
	Start-Process powershell -ArgumentList '-noprofile Set-ExecutionPolicy unrestricted -s cu' -verb RunAs
}

Function Install-Scoop {
	[Environment]::SetEnvironmentVariable("SCOOP", "$HOME\.scoop", "User")

	Invoke-WebRequest 'https://get.scoop.sh' | Invoke-Expression

	'scoop install Git-with-OpenSSH Sudo Which --global' | Set-Content -path temp_script.ps1
	Start-Process PowerShell -verb RunAs -argument "-noProfile $(Convert-Path .\temp_script.ps1)"
	Remove-Item temp_script.ps1 -force

	scoop bucket add Extras
}

Function Install-Chocolatey {
	Install-PackageProvider Chocolatey -scope CurrentUser
	Set-PackageSource -name Chocolatey -trusted
}

Function Install-ChocolateyPackages {
	PARAM(
		[Parameter( Mandatory )]
		[String[]] $packages
	)

	$packages | ForEach { Install-Package $_ -verbose }
}

Function Install-ScoopPackages {
	PARAM(
		[Parameter( Mandatory )]
		[String[]] $packages
	)
	
	$packages | ForEach { scoop install $_ }
}

$chocoPackages = @(
	'googlechrome',
	'google-backup-and-sync',
	'jetbrainstoolbox',
	'vnc-viewer',
	'authy-desktop',
	'toggl',
	'plexmediaplayer'
)

$scoopPackages = @(
	'7zip',
	'cmder',
	'vscode',
	'windirstat',
	'vlc',
	'putty',
	'greenshot',
	'firefox-developer',
	'audacity',
	'mpc-hc',
	'hyper',
	'notepad2',
	'heidisql',
	'gitkraken',
	'speccy',
	'etcher',
	'discord'
)

Install-Scoop
sudo Install-Chocolatey

Install-ScoopPackages $scoopPackages 
sudo Install-ChocolateyPackages $chocoPackages
