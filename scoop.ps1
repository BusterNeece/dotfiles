# Install "Developer Mode" tools first and set execution policy to RemoteSigned

iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
	
scoop install git openssh sudo which
scoop bucket add Extras

scoop install vscode 7zip cmder gitkraken speccy etcher jetbrains-toolbox postman
