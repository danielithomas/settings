#!/bin/bash
# Runtime entry point — sourced from .bashrc/.zshrc via the injected config block.
# Sources aliases and helpers.

# Resolve script directory (works in both bash and zsh)
SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"

# Source alias files
if [ -f "$SCRIPTS_DIR/lib/aliases-common.sh" ]; then
    source "$SCRIPTS_DIR/lib/aliases-common.sh"
fi

if [ -f "$SCRIPTS_DIR/lib/aliases-linux.sh" ]; then
    source "$SCRIPTS_DIR/lib/aliases-linux.sh"
fi
