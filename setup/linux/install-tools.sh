#!/bin/bash

# ------------------------------------------------------
# Install-cool-tools
# ------------------------------------------------------

BASEDIR=$(dirname "$0")
echo "$BASEDIR"

source $BASEDIR/install-base.sh

# Install Dotnet
source $BASEDIR/install-dotnet.sh

# Install snaps
source $BASEDIR/install-snaps.sh

# Install Dart
source $BASEDIR/install-dart.sh

# TODO: MSTeams
# https://go.microsoft.com/fwlink/p/?LinkID=2112886&clcid=0xc09&culture=en-au&country=AU
