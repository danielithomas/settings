#!/bin/bash
# Module: Claude Code CLI (npm-based)

SETUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$SETUP_DIR/lib.sh"

if [[ "${FORCE_INSTALL:-}" != "true" ]] && is_installed claude; then
    log_info "Claude Code is already installed, skipping."
    exit 0
fi

# Ensure Node.js is available
if ! is_installed node; then
    log_info "Node.js not found, installing via NodeSource..."
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt install -y nodejs
fi

log_info "Installing Claude Code CLI..."
sudo npm install -g @anthropic-ai/claude-code

log_info "Claude Code installed."
