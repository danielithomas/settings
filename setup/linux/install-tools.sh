#!/bin/bash

# ------------------------------------------------------
# Install-cool-tools
# ------------------------------------------------------

# NOTE: Assumed git already installed
# sudo apt install git

sudo apt update
sudo apt upgrade

# Install cowsay, fortune and lolcat
# chrome-gnome-shell - allow gnome extension activations
# dconf-tools - for tweaking the dock
sudo apt install fortune cowsay lolcat vim wget gpg apt-transport-https

# Install Gnome Tweaks from Ubuntu store
sudo apt install gnome-tweaks chrome-gnome-shell 

# Install Dotnet
source install-dotnet.sh

#
# Other Development Tools
# Assumes Snap is installed
#

if ! command -v snap &> /dev/null
then
    echo "Snap not found - trying to install"
    sudo apt install snapd

    # snap store
    sudo snap install snap-store
fi

# Visual Studio Code
sudo snap install code --classic

# Microsoft Powershell
sudo snap install powershell --classic

# Install Dart Programming Language SDK

wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/dart.gpg
echo 'deb [signed-by=/usr/share/keyrings/dart.gpg arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' | sudo tee /etc/apt/sources.list.d/dart_stable.list

sudo apt update
sudo apt install dart

# Export Path
echo 'export PATH="$PATH:/usr/lib/dart/bin"' >> ~/.profile

# TODO: MSTeams
# https://go.microsoft.com/fwlink/p/?LinkID=2112886&clcid=0xc09&culture=en-au&country=AU
