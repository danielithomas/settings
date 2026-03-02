#!/bin/bash
# Common aliases — loaded on every shell launch

alias makepass='openssl rand -base64 12'
alias backup-shell='source $CUST_SCRIPTS/lib/backup-profile.sh'
alias help-me='source $CUST_SCRIPTS/help/help-me.sh'
alias reload-shell='exec -l $SHELL'
