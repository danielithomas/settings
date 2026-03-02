#!/bin/bash
# Help command dispatcher — shows common + platform-specific help

_lol() {
    if command -v lolcat &>/dev/null; then
        lolcat
    else
        cat
    fi
}

cat "$CUST_SCRIPTS/help/help-me.txt" | _lol

if [[ "$(uname)" == "Linux" ]]; then
    cat "$CUST_SCRIPTS/help/help-linux.txt" | _lol
fi

echo "|------------------------------------------------------------------|" | _lol
echo ""

unset -f _lol
