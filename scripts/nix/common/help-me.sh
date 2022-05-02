#!/bin/bash

# Help Me - list out useful commands

cat $CUST_SCRIPTS/common/help-me.txt | lolcat

if uname -a | grep -q "Darwin"; then
	# echo "we're on a Mac!"
    cat $CUST_SCRIPTS/mac/help-mac.txt | lolcat	
fi

if uname -a | grep -q "Linux"; then
	# echo "we're on a Mac!"
    #cat $CUST_SCRIPTS/linux/help-linux.txt | lolcat	
	source $CUST_SCRIPTS/linux/help-linux.sh
fi

echo "|------------------------------------------------------------------|" | lolcat
echo ""