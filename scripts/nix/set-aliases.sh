#!/bin/bash

# ---------------------------------------------------------
# Set Aliases - Sets up Aliases for various scripts
# ---------------------------------------------------------

if uname | grep -q "Darwin"; then
	# On Mac
	source $CUST_SCRIPTS/mac/set-mac-specific-aliases.sh
fi

if uname | grep -q "Linux"; then
	# On Linux
	source $CUST_SCRIPTS/linux/set-linux-specific-aliases.sh
fi 

# Set the common aliases
source $CUST_SCRIPTS/common/set-common-aliases.sh


