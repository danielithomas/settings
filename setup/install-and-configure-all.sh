#!/bin/bash

BASEDIR=$(dirname "$0")

if uname -a | grep -q "Darwin"; then
	# echo "we're on a Mac!"
    source $BASEDIR/mac/install-mac-tools.sh
fi

if uname -a | grep -q "Linux"; then
	# echo "we're on a Linux!"
   source $BASEDIR/linux/install-tools.sh

fi

source ./install-config.sh