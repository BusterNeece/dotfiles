#/usr/bin/env bash

sudo dpkg --add-architecture i386 

# Install Wine staging
wget -nc https://dl.winehq.org/wine-builds/winehq.key
sudo apt-key add winehq.key
sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ cosmic main'

sudo apt-get update
sudo apt install -y --install-recommends winehq-staging

# Install Lutris
sudo add-apt-repository -y ppa:lutris-team/lutris
sudo apt-get update
sudo apt-get install lutris

# Install DXVK
sudo add-apt-repository -y ppa:paulo-miguel-dias/pkppa
sudo apt update && sudo apt upgrade
sudo apt install -y libgl1-mesa-glx:i386 libgl1-mesa-dri:i386

# Install Vulkan
sudo apt install -y mesa-vulkan-drivers mesa-vulkan-drivers:i386
