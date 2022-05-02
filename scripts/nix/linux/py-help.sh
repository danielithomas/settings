#!/bin/bash

# Useful python commands

cat $CUST_SCRIPTS/linux/py-help.txt | lolcat

# conda info --envs | lolcat
# | source         | Use source activate <env> to switch             |
# | activate <env> | environments                                    |

if [ -d $HOME/anaconda3 ]; then
    cat $CUST_SCRIPTS/linux/conda-help.txt | lolcat
fi

echo "|------------------------------------------------------------------|" | lolcat