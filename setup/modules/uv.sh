#!/bin/bash
# Module: uv Python package manager (Astral)

SETUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$SETUP_DIR/lib.sh"

if [[ "${FORCE_INSTALL:-}" != "true" ]] && is_installed uv; then
    log_info "uv is already installed, skipping."
    exit 0
fi

log_info "Installing uv..."
curl -LsSf https://astral.sh/uv/install.sh | sh

log_info "uv installed."
