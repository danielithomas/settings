#!/bin/bash
# Module: Dart SDK via Google apt repo

SETUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$SETUP_DIR/lib.sh"

if [[ "${FORCE_INSTALL:-}" != "true" ]] && is_installed dart; then
    log_info "Dart SDK is already installed, skipping."
    exit 0
fi

log_info "Installing Dart SDK from Google apt repo..."

# Add Google signing key
curl -fsSL https://dl-ssl.google.com/linux/linux_signing_key.pub \
    | sudo gpg --dearmor -o /usr/share/keyrings/dart-archive-keyring.gpg

# Add Dart stable repo
echo "deb [signed-by=/usr/share/keyrings/dart-archive-keyring.gpg] \
https://storage.googleapis.com/dart-archive/channels/stable/release/latest/linux/packages/dart/debian stable main" \
    | sudo tee /etc/apt/sources.list.d/dart_stable.list > /dev/null

sudo apt update
sudo apt install -y dart

log_info "Dart SDK installed."
