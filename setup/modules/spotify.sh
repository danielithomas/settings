#!/bin/bash
# Module: Spotify via Snap

SETUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$SETUP_DIR/lib.sh"

if [[ "${FORCE_INSTALL:-}" != "true" ]] && snap list spotify &>/dev/null; then
    log_info "Spotify is already installed, skipping."
    exit 0
fi

if ! command -v snap &>/dev/null; then
    log_info "Installing snapd..."
    sudo apt-get install -y snapd
fi

log_info "Installing Spotify via Snap..."
sudo snap install spotify

log_info "Spotify installed."
