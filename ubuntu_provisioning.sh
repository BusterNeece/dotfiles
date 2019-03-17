#/usr/bin/env bash

sudo apt-get update

# Core OS-level software
sudo apt-get install -y git sudo curl wget vim arc-theme gnome-tweak-tool

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

cd ~

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
