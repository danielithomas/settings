#!/bin/bash
# Display Python / uv help

_lol() {
    if command -v lolcat &>/dev/null; then
        lolcat
    else
        cat
    fi
}

cat "$CUST_SCRIPTS/help/help-python.txt" | _lol
echo "|------------------------------------------------------------------|" | _lol

unset -f _lol
