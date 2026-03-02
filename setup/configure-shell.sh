#!/bin/bash
# Idempotent shell configuration injection.
# Injects the config block from config/shell-config.sh into .bashrc or .zshrc
# using sentinel markers so re-runs replace rather than duplicate.

SETUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SETUP_DIR/lib.sh"

# Read the config template
CONFIG_FILE="$SETUP_DIR/config/shell-config.sh"
if [[ ! -f "$CONFIG_FILE" ]]; then
    log_error "Config template not found: $CONFIG_FILE"
    exit 1
fi

CONFIG_CONTENT="$(cat "$CONFIG_FILE")"

# Detect which RC file to use
RC_FILE="$(detect_rc_file)"

# Inject config
inject_config "$RC_FILE" "$CONFIG_CONTENT"

# Ensure ~/config directory exists
if [[ ! -d "$HOME/config" ]]; then
    log_info "Creating ~/config directory"
    mkdir -p "$HOME/config"
fi

log_info "Shell configuration written to $RC_FILE"
log_info "Run 'exec -l \$SHELL' or open a new terminal to apply changes."
