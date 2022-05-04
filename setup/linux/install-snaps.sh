#!/bin/bash

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

