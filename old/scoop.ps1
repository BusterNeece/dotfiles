# Install "Developer Mode" tools first and set execution policy to RemoteSigned

iex (new-object net.webclient).downloadstring('https://get.scoop.sh')

scoop install git openssh sudo which aria2

# Often installed via Scoop
scoop bucket add extras
scoop install 7zip cmder gitkraken speccy etcher postman

# Sometimes installed via Scoop or Ninite
scoop install jetbrains-toolbox

# Also available: vscode
