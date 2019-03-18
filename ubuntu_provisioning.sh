#/usr/bin/env bash

sudo apt-get update

# Core OS-level software
sudo apt-get install -y git sudo curl wget vim arc-theme gnome-tweak-tool fonts-firacode

sudo apt-get autoremove

# Snap Software installation
sudo snap install gitkraken spotify discord telegram-desktop 

sudo snap install slack --classic
sudo snap install vscode --classic
sudo snap install phpstorm --classic

# Install Chrome
cd ~/Downloads
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb

# Install Docker
curl -fsSL get.docker.com -o get-docker.sh
sh get-docker.sh
rm get-docker.sh

sudo usermod -aG docker `whoami`

# Install Docker Compose
COMPOSE_VERSION=`git ls-remote https://github.com/docker/compose | grep refs/tags | grep -oP "[0-9]+\.[0-9][0-9]+\.[0-9]+$" | tail -n 1`
sudo sh -c "curl -L https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose"
sudo chmod +x /usr/local/bin/docker-compose
sudo sh -c "curl -L https://raw.githubusercontent.com/docker/compose/${COMPOSE_VERSION}/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose"

# Install Cryptomator
sudo add-apt-repository ppa:sebastian-stenzel/cryptomator
sudo apt-get update
sudo apt-get install cryptomator

# Install keybase
curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
sudo dpkg -i keybase_amd64.deb
sudo apt-get install -f
# Execute run_keybase to run afterward

# Use local clock at system level
timedatectl set-local-rtc 1 --adjust-system-clock

# Increase inotify watches limit
echo "fs.inotify.max_user_watches = 524288" | sudo tee /etc/sysctl.d/jetbrains.conf
sudo sysctl -p --system

# Fix Discord audio
sudo sed -i 's/load-module module-udev-detect/load-module module-udev-detect tsched=0/' /etc/pulse/default.pa
pulseaudio -k && sudo alsa force-reload

# Fix Spotify HiDPI
sudo sed -i 's/%U/--force-device-scale-factor=2.0 %U/' /var/lib/snapd/desktop/applications/spotify_spotify.desktop

# Add docker.local to hosts
echo "127.0.0.1  docker.local" | sudo tee -a /etc/hosts

# Code repositories
mkdir -p ~/Documents/Web/AzuraCast
cd ~/Documents/Web/AzuraCast

git clone https://github.com/AzuraCast/AzuraCast.git
git clone https://github.com/AzuraCast/docker-azuracast-web-v2.git
git clone https://github.com/AzuraCast/docker-azuracast-db.git
git clone https://github.com/AzuraCast/docker-azuracast-influxdb.git
git clone https://github.com/AzuraCast/docker-azuracast-redis.git
git clone https://github.com/AzuraCast/docker-azuracast-radio.git

cd AzuraCast

cp azuracast.dev.env azuracast.env
cp docker-compose.dev.yml docker-compose.yml

echo "Initial provision complete. Reboot necessary for Docker."
