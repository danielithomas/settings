#!/bin/bash
# Module: GNOME Tweaks + gnome-browser-connector

SETUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$SETUP_DIR/lib.sh"

PACKAGES=()

if [[ "${FORCE_INSTALL:-}" == "true" ]]; then
    PACKAGES=(gnome-tweaks gnome-browser-connector)
else
    is_pkg_installed gnome-tweaks            || PACKAGES+=(gnome-tweaks)
    is_pkg_installed gnome-browser-connector || PACKAGES+=(gnome-browser-connector)

    if [[ ${#PACKAGES[@]} -eq 0 ]]; then
        log_info "GNOME Tweaks and browser connector already installed, skipping."
        exit 0
    fi
fi

log_info "Installing: ${PACKAGES[*]}"
sudo apt install -y "${PACKAGES[@]}"

log_info "GNOME Tweaks installed."
