#!/bin/bash
# Module: Fun terminal tools (fortune, cowsay, lolcat)

SETUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$SETUP_DIR/lib.sh"

PACKAGES=()

if [[ "${FORCE_INSTALL:-}" == "true" ]]; then
    PACKAGES=(fortune-mod cowsay lolcat)
else
    is_installed fortune  || PACKAGES+=(fortune-mod)
    is_installed cowsay   || PACKAGES+=(cowsay)
    is_installed lolcat   || PACKAGES+=(lolcat)

    if [[ ${#PACKAGES[@]} -eq 0 ]]; then
        log_info "Fun tools already installed, skipping."
        exit 0
    fi
fi

log_info "Installing fun tools: ${PACKAGES[*]}"
sudo apt install -y "${PACKAGES[@]}"

log_info "Fun tools installed."
