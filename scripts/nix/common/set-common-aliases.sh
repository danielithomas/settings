#!/bin/bash

# ---------------------------------------------------------
# Set common aliases
# ---------------------------------------------------------

# echo 'setting aliases'
alias makepass='openssl rand -base64 12'
alias backup-bash='source $CUST_SCRIPTS/common/backup-profile.sh'
alias help-me='source $CUST_SCRIPTS/common/help-me.sh'
alias reload-bash='exec -l $SHELL'

