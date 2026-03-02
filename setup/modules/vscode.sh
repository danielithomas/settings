#!/bin/bash
# Module: Visual Studio Code via Microsoft apt repo (not snap)

SETUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$SETUP_DIR/lib.sh"

if [[ "${FORCE_INSTALL:-}" != "true" ]] && is_installed code; then
    log_info "VS Code is already installed, skipping."
    exit 0
fi

log_info "Installing VS Code from Microsoft apt repo..."

# Import Microsoft GPG key
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc \
    | sudo gpg --dearmor -o /usr/share/keyrings/packages.microsoft.gpg

# Add repo
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/packages.microsoft.gpg] \
https://packages.microsoft.com/repos/code stable main" \
    | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null

sudo apt update
sudo apt install -y code

log_info "VS Code installed."
