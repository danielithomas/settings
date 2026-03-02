#!/bin/bash
# Module: Fastfetch (system info display, replaces neofetch)

SETUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$SETUP_DIR/lib.sh"

if [[ "${FORCE_INSTALL:-}" != "true" ]] && is_installed fastfetch; then
    log_info "Fastfetch is already installed, skipping."
    exit 0
fi

# Try apt first (available on newer Ubuntu/Debian)
if apt-cache show fastfetch &>/dev/null 2>&1; then
    log_info "Installing fastfetch via apt..."
    sudo apt install -y fastfetch
else
    # Fall back to GitHub .deb release
    log_info "Fastfetch not in apt repos, installing from GitHub release..."
    ARCH="$(dpkg --print-architecture)"
    LATEST_URL="$(curl -fsSL https://api.github.com/repos/fastfetch-cli/fastfetch/releases/latest \
        | grep "browser_download_url.*linux-${ARCH}\.deb" \
        | head -1 \
        | cut -d '"' -f 4)"

    if [[ -z "$LATEST_URL" ]]; then
        log_error "Could not find fastfetch .deb for architecture: $ARCH"
        exit 1
    fi

    TMP_DEB="$(mktemp /tmp/fastfetch-XXXXXX.deb)"
    curl -fsSL -o "$TMP_DEB" "$LATEST_URL"
    sudo dpkg -i "$TMP_DEB"
    rm -f "$TMP_DEB"
fi

log_info "Fastfetch installed."
