#!/bin/bash
# Module: .NET SDK via official install script

SETUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$SETUP_DIR/lib.sh"

if [[ "${FORCE_INSTALL:-}" != "true" ]] && is_installed dotnet; then
    log_info ".NET SDK is already installed, skipping."
    exit 0
fi

log_info "Installing .NET SDK via official install script..."

curl -fsSL https://dot.net/v1/dotnet-install.sh -o /tmp/dotnet-install.sh
chmod +x /tmp/dotnet-install.sh
/tmp/dotnet-install.sh --channel LTS
rm -f /tmp/dotnet-install.sh

log_info ".NET SDK installed to ~/.dotnet"
log_info "PATH will be configured via shell config."
