#!/bin/bash
# Module: GNOME Boxes (virtualisation)

SETUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$SETUP_DIR/lib.sh"

if [[ "${FORCE_INSTALL:-}" != "true" ]] && is_pkg_installed gnome-boxes; then
    log_info "GNOME Boxes is already installed, skipping."
    exit 0
fi

log_info "Installing GNOME Boxes..."
sudo apt install -y gnome-boxes

log_info "GNOME Boxes installed."
