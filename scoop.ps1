# Make sure we're in a reasonable execution policy
if((Get-ExecutionPolicy) -ne 'Unrestricted')
{
	Start-Process powershell -ArgumentList '-noprofile Set-ExecutionPolicy unrestricted -s cu' -verb RunAs
}

# Check if scoop exists, install if no
if ((Get-Command 'scoop' -errorAction SilentlyContinue) -eq '')
{
	iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
}

# Configure Scoop to use ~/.scoop, regardless of silly domain settings
[Environment]::SetEnvironmentVariable("SCOOP", "$HOME\.scoop", "User")

# We need git to successfully use scoop
scoop install git-with-openssh
scoop bucket add extras
scoop update

# Sudo approximates the *nix command
scoop install sudo

# Install utils and terminal tools
scoop install 7zip cmder

# Install the Ninite-type stuff
scoop install vscode windirstat vlc putty greenshot firefox-developer audacity mpc-hc

# Install other dev tools extras
scoop install hyper notepad2 heidisql gitkraken 

# Install other goodies
scoop install speccy etcher discord