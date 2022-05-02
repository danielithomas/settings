#!/bin/bash

# Help Me - list out useful commands

if uname -a | grep -q "Linux"; then
	# echo "we're on Linux!"
    cat $CUST_SCRIPTS/linux/help-linux.txt | lolcat	
fi

#echo "|------------------------------------------------------------------|" | lolcat
#echo ""