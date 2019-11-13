# Install "Developer Mode" tools first and set execution policy to RemoteSigned

# If using the W: second partition
$env:SCOOP='W:\Scoop'
[Environment]::SetEnvironmentVariable('SCOOP', $env:SCOOP, 'User')

$env:SCOOP_GLOBAL='W:\ScoopGlobal'
[Environment]::SetEnvironmentVariable('SCOOP_GLOBAL', $env:SCOOP_GLOBAL, 'Machine')

iex (new-object net.webclient).downloadstring('https://get.scoop.sh')

scoop install --global git openssh sudo which aria2 gpg

# Often installed via Scoop
scoop bucket add extras
scoop install 7zip cmder gitkraken speccy etcher postman

# Sometimes installed via Scoop or Ninite
scoop install vscode jetbrains-toolbox
