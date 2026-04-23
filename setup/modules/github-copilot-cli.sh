#!/bin/bash
# Module: GitHub Copilot CLI (npm-based)

SETUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$SETUP_DIR/lib.sh"

if [[ "${FORCE_INSTALL:-}" != "true" ]] && is_installed copilot; then
    log_info "GitHub Copilot CLI is already installed, skipping."
    exit 0
fi

# Ensure Node.js is available
if ! is_installed node; then
    log_info "Node.js not found, installing via NodeSource..."
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt install -y nodejs
fi

log_info "Installing GitHub Copilot CLI..."
sudo npm install -g @github/copilot

log_info "GitHub Copilot CLI installed. Run 'copilot' and sign in with your GitHub account."
