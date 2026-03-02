#!/bin/bash
# Shell greeting — displayed on each new interactive shell.
# Usage: source shell-launch.sh [cowsay-creature]

cowname="${1:-stegosaurus}"
welcome=" >>> Welcome to $(hostname) <<<"
helpmsg=" >>> Type 'help-me' for more commands <<<  "

# Guard: only show greeting if the required tools are available
if ! command -v fortune &>/dev/null || ! command -v cowsay &>/dev/null; then
    return 0 2>/dev/null || exit 0
fi

_lol() {
    if command -v lolcat &>/dev/null; then
        lolcat
    else
        cat
    fi
}

echo "=============================================================================" | _lol
echo
fortune -s | cowsay -f "$cowname" | _lol
echo
printf "%*s\n" $(((${#welcome}+80)/2)) "$welcome" | _lol
printf "%*s\n" $(((${#helpmsg}+80)/2)) "$helpmsg" | _lol
echo
echo "=============================================================================" | _lol
echo

unset -f _lol
