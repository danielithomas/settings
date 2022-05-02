#!/bin/bash

if ! command -v brew &> /dev/null
then
    echo "Brew not found. Installing..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

#
# Base
#
brew install fortune cowsay lolcat vim 

#
# Powershell
#
brew install powershell

# 
# Dart
#
brew tap dart-lang/dart
brew install dart
