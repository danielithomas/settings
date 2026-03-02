#!/bin/bash
# Module: Nerd Fonts — installs a default selection of Nerd Fonts

SETUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$SETUP_DIR/lib.sh"

REPO_DIR="$(dirname "$SETUP_DIR")"
INSTALLER="$REPO_DIR/scripts/lib/install-nerd-font.sh"

DEFAULT_FONTS=(
    Agave
    AnonymousPro
    IBMPlexMono
    Hack
    Inconsolata
    RobotoMono
    UbuntuMono
)

# Ensure unzip is available
if ! is_installed unzip; then
    log_info "Installing unzip..."
    sudo apt install -y unzip
fi

log_info "Installing default Nerd Fonts: ${DEFAULT_FONTS[*]}"
bash "$INSTALLER" "${DEFAULT_FONTS[@]}"

log_info "Nerd Fonts installed."
