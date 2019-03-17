#/usr/bin/env bash

sudo dpkg --add-architecture i386 

# Install Wine staging
wget -nc https://dl.winehq.org/wine-builds/winehq.key
sudo apt-key add winehq.key
sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ cosmic main'

sudo apt-get update
sudo apt install -y --install-recommends winehq-staging

# Install Lutris
ver=$(lsb_release -sr); if [ $ver != "18.10" -a $ver != "18.04" -a $ver != "16.04" ]; then ver=18.04; fi
echo "deb http://download.opensuse.org/repositories/home:/strycore/xUbuntu_$ver/ ./" | sudo tee /etc/apt/sources.list.d/lutris.list
wget -q https://download.opensuse.org/repositories/home:/strycore/xUbuntu_$ver/Release.key -O- | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y lutris

# Install DXVK
sudo dpkg --add-architecture i386
sudo add-apt-repository -y ppa:paulo-miguel-dias/pkppa
sudo apt update && sudo apt upgrade
sudo apt install -y libgl1-mesa-glx:i386 libgl1-mesa-dri:i386

# Install Vulkan
sudo apt install -y mesa-vulkan-drivers mesa-vulkan-drivers:i386