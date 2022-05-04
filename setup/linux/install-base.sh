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
