#!/bin/bash
# Module: Telegram via Flatpak

SETUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$SETUP_DIR/lib.sh"

if [[ "${FORCE_INSTALL:-}" != "true" ]] && flatpak list 2>/dev/null | grep -q org.telegram.desktop; then
    log_info "Telegram is already installed, skipping."
    exit 0
fi

ensure_flatpak

log_info "Installing Telegram via Flatpak..."
flatpak install -y flathub org.telegram.desktop

log_info "Telegram installed."
