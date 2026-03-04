#!/bin/bash
# Module: Peon Ping — audio notifications for AI coding agents

SETUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$SETUP_DIR/lib.sh"

if [[ "${FORCE_INSTALL:-}" != "true" ]] && is_installed peon-ping; then
    log_info "Peon Ping is already installed, skipping."
    exit 0
fi

log_info "Installing Peon Ping..."
curl -fsSL peonping.com/install | bash

log_info "Peon Ping installed."
