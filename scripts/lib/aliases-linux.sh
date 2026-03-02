#!/bin/bash
# Linux-specific aliases

# Python / uv
alias py-help='source $CUST_SCRIPTS/help/py-help.sh'
alias activate-env='source ./.venv/bin/activate'
alias create-env='uv venv'
alias uv-init='uv init'
alias uv-sync='uv sync'

# Nerd Fonts
alias install-nerd-font='bash $CUST_SCRIPTS/lib/install-nerd-font.sh'
