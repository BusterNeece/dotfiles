# Make sure we're in a reasonable execution policy
if((Get-ExecutionPolicy) -ne 'Unrestricted')
{
	Start-Process powershell -ArgumentList '-noprofile Set-ExecutionPolicy unrestricted -s cu' -verb RunAs
}

Function Install-Scoop {
	if ((Get-Command 'scoop' -errorAction SilentlyContinue) -eq '')
	{
		[Environment]::SetEnvironmentVariable("SCOOP", "$HOME\.scoop", "User")
		iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
	}
	
	scoop install git
	scoop install openssh sudo which
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
	'hyper',
	'notepad2',
	'heidisql',
	'gitkraken',
	'speccy',
	'etcher',
	'discord'
)

$chocoPackages = @(
	'googlechrome',
	'google-backup-and-sync',
	'jetbrainstoolbox',
	'vnc-viewer',
	'authy-desktop',
	'toggl',
	'plexmediaplayer',
	'k-litecodecpackfull',
	'shutup10'
)

Install-Scoop
sudo Install-Chocolatey

Install-ScoopPackages $scoopPackages 
sudo Install-ChocolateyPackages $chocoPackages
