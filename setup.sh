#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive
export USERNAME=`whoami`

# Configure Git
git config --global user.name Buster "Silver Eagle" Neece
git config --global user.email loobalightdark@gmail.com
git config --global init.defaultBranch main

# Update and install required packages
sudo apt-get update
sudo apt-get -y install --no-install-recommends apt-utils dialog 2>&1
sudo apt-get install -y \
  make

# Cleanup
sudo apt-get autoremove -y
sudo apt-get autoremove -y
sudo rm -rf /var/lib/apt/lists/*
