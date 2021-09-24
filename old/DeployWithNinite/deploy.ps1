# Make sure we're in a reasonable execution policy
if((Get-ExecutionPolicy) -ne 'Unrestricted')
{
	Start-Process powershell -ArgumentList '-noprofile Set-ExecutionPolicy unrestricted -s cu' -verb RunAs
}

Function Install-Scoop {
	[Environment]::SetEnvironmentVariable("SCOOP", "$HOME\.scoop", "User")
	iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
	
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
	'notepad2',
	'heidisql',
	'gitkraken',
	'speccy',
	'etcher',
	'discord'
)

$chocoPackages = @(
	'jetbrainstoolbox',
	'vnc-viewer',
	'authy-desktop',
	'toggl',
	'plexmediaplayer',
	'shutup10'
)

Install-Scoop
Install-Chocolatey

Install-ScoopPackages $scoopPackages 
Install-ChocolateyPackages $chocoPackages
