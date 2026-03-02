#!/bin/bash
# Module: PowerShell via Microsoft apt repo (not snap)

SETUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$SETUP_DIR/lib.sh"

if [[ "${FORCE_INSTALL:-}" != "true" ]] && is_installed pwsh; then
    log_info "PowerShell is already installed, skipping."
    exit 0
fi

log_info "Installing PowerShell from Microsoft apt repo..."

# Import Microsoft GPG key (may already exist from vscode module)
if [[ ! -f /usr/share/keyrings/packages.microsoft.gpg ]]; then
    curl -fsSL https://packages.microsoft.com/keys/microsoft.asc \
        | sudo gpg --dearmor -o /usr/share/keyrings/packages.microsoft.gpg
fi

# Detect Ubuntu version for the repo URL
source /etc/os-release
REPO_URL="https://packages.microsoft.com/config/${ID}/${VERSION_ID}/packages-microsoft-prod.deb"

TMP_DEB="$(mktemp /tmp/ms-prod-XXXXXX.deb)"
curl -fsSL -o "$TMP_DEB" "$REPO_URL"
sudo dpkg -i "$TMP_DEB"
rm -f "$TMP_DEB"

sudo apt update
sudo apt install -y powershell

log_info "PowerShell installed."
