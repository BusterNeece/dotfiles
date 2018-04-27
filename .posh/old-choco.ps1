# Make sure we're in a reasonable execution policy
if((Get-ExecutionPolicy) -ne 'Unrestricted')
{
	Start-Process powershell -ArgumentList '-noprofile Set-ExecutionPolicy unrestricted -s cu' -verb RunAs
}

# Check if choco exists, install if no
if ((Get-Command 'choco' -errorAction SilentlyContinue) -eq '')
{
	iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Google stuff
choco install googlechrome google-backup-and-sync

# Code Tools not available in Scoop
choco install jetbrainstoolbox

# VNC Viewer
choco install vnc-viewer

# Authy 2FA Tool
choco install authy-desktop

# Toggl desktop
choco install toggl

# Plex media player
choco install plexmediaplayer
