#!/bin/bash

# ------------------------------------------------------
# Set Aliases - Sets up Aliases for various scripts
# ------------------------------------------------------

# start tensorflow virtual environment
#alias tf-start='source ~/dev/tensorflow/bin/activate'

# Azure-related aliases
# alias az-help='source $CUST_SCRIPTS/az-help.sh'

# Python-related aliases
alias py-help='source $CUST_SCRIPTS/linux/py-help.sh'
alias activate-env='source ./.venv/bin/activate'
alias create-env='python3 -m venv .venv'

if [ -d $HOME/anaconda3 ]; then
	# Anaconda Python (Data-science stuff)
	alias conda-info='conda info --envs | lolcat'
	alias conda-off='conda deactivate'
	alias spyder-run='spyder & disown'

fi

