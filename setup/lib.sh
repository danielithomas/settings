#!/bin/bash
# Shared library for setup scripts
# Source this file from install.sh and individual modules

set -euo pipefail

# Colour codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No colour

# Path resolution
SETUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SETUP_DIR")"

# ─── Logging ────────────────────────────────────────────────────────────────

log_info() {
    echo -e "${GREEN}[INFO]${NC} $*"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $*"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $*" >&2
}

log_step() {
    echo -e "${BLUE}[STEP]${NC} $*"
}

# ─── Pre-flight checks ─────────────────────────────────────────────────────

require_linux() {
    if [[ "$(uname)" != "Linux" ]]; then
        log_error "This installer only supports Linux."
        exit 1
    fi
}

require_debian_based() {
    if ! command -v apt &>/dev/null; then
        log_error "This installer requires a Debian-based distro (apt not found)."
        exit 1
    fi
}

require_not_root() {
    if [[ "$EUID" -eq 0 ]]; then
        log_error "Do not run this script as root. It will use sudo when needed."
        exit 1
    fi
}

# ─── Helpers ────────────────────────────────────────────────────────────────

is_installed() {
    command -v "$1" &>/dev/null
}

is_pkg_installed() {
    dpkg -s "$1" &>/dev/null 2>&1
}

# Run a module by name. Expects modules in $SETUP_DIR/modules/<name>.sh
run_module() {
    local name="$1"
    local module_path="$SETUP_DIR/modules/${name}.sh"

    if [[ ! -f "$module_path" ]]; then
        log_error "Module not found: $module_path"
        return 1
    fi

    log_step "Running module: $name"
    if bash "$module_path"; then
        log_info "Module '$name' completed successfully."
    else
        log_warn "Module '$name' finished with errors (exit code $?)."
    fi
}

# Ensure flatpak and flathub remote are available
ensure_flatpak() {
    if ! is_installed flatpak; then
        log_info "Installing flatpak..."
        sudo apt install -y flatpak
    fi
    if ! flatpak remotes | grep -q flathub; then
        log_info "Adding Flathub remote..."
        flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    fi
}

# Idempotent config injection using sentinel markers.
# Usage: inject_config <rc_file> <config_content>
inject_config() {
    local rc_file="$1"
    local config_content="$2"
    local start_marker="# >>> settings-repo-config >>>"
    local end_marker="# <<< settings-repo-config <<<"

    local new_block
    new_block=$(printf '%s\n%s\n%s' "$start_marker" "$config_content" "$end_marker")

    if [[ ! -f "$rc_file" ]]; then
        log_info "Creating $rc_file with config block."
        echo "$new_block" >> "$rc_file"
        return
    fi

    if grep -qF "$start_marker" "$rc_file"; then
        log_info "Replacing existing config block in $rc_file"
        awk -v start="$start_marker" -v end="$end_marker" -v block="$new_block" '
            $0 == start { skip=1; printed=1; print block; next }
            $0 == end   { skip=0; next }
            !skip       { print }
        ' "$rc_file" > "${rc_file}.tmp"
        mv "${rc_file}.tmp" "$rc_file"
    else
        log_info "Appending config block to $rc_file"
        printf '\n%s\n' "$new_block" >> "$rc_file"
    fi
}

# Detect the correct RC file based on current shell
detect_rc_file() {
    local shell_name
    shell_name="$(basename "${SHELL:-/bin/bash}")"
    case "$shell_name" in
        zsh)  echo "$HOME/.zshrc" ;;
        *)    echo "$HOME/.bashrc" ;;
    esac
}
