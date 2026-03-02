#!/bin/bash
# Module: Core tools via apt
# Installs vim, wget, curl, git, gpg, apt-transport-https, software-properties-common

SETUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$SETUP_DIR/lib.sh"

PACKAGES=(
    vim
    wget
    curl
    git
    gpg
    apt-transport-https
    software-properties-common
)

log_info "Updating apt package lists..."
sudo apt update

log_info "Installing core packages: ${PACKAGES[*]}"
sudo apt install -y "${PACKAGES[@]}"

log_info "Core tools installed."
