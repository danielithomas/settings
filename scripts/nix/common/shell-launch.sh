#!/bin/bash

# SHELL LAUNCH

# ------------------------------------------------------
# Fun Stuff - Getting cow to say your fortune!
# ------------------------------------------------------
cowname="$1"
welcome=" >>> Welcome to $(hostname) <<<"
helpmsg=" >>> Type 'help-me' for more commands <<<  "

echo "=============================================================================" | lolcat
echo
fortune -s | cowsay -f $cowname | lolcat
echo
printf "%*s\n" $(((${#welcome}+80)/2)) "$welcome" | lolcat
printf "%*s\n" $(((${#helpmsg}+80)/2)) "$helpmsg" | lolcat
echo
echo "=============================================================================" | lolcat
echo
