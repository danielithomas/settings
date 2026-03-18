#!/bin/bash
# Module: Document processing tools (pandoc, texlive)

SETUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$SETUP_DIR/lib.sh"

PACKAGES=()

if [[ "${FORCE_INSTALL:-}" == "true" ]]; then
    PACKAGES=(pandoc texlive-latex-recommended)
else
    is_installed pandoc                        || PACKAGES+=(pandoc)
    is_pkg_installed texlive-latex-recommended  || PACKAGES+=(texlive-latex-recommended)

    if [[ ${#PACKAGES[@]} -eq 0 ]]; then
        log_info "Document processing tools already installed, skipping."
        exit 0
    fi
fi

log_info "Installing document processing tools: ${PACKAGES[*]}"
sudo apt install -y "${PACKAGES[@]}"

log_info "Document processing tools installed."
