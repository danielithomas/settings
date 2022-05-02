#!/bin/bash

if uname -a | grep -q "Darwin"; then
	# echo "we're on a Mac!"
    source ./mac/install-mac-tools.sh
fi

if uname -a | grep -q "Linux"; then
	# echo "we're on a Linux!"
   source ./linux/install-tools.sh

fi

source ./install-config.sh