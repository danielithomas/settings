#!/bin/bash
# Main entry point — interactive installer using whiptail
# Usage: bash ~/settings/setup/install.sh [--force]

SETUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SETUP_DIR/lib.sh"

# ─── Parse arguments ──────────────────────────────────────────────────────

FORCE_INSTALL=false
for arg in "$@"; do
    case "$arg" in
        --force) FORCE_INSTALL=true ;;
        *) log_error "Unknown argument: $arg"; exit 1 ;;
    esac
done
export FORCE_INSTALL

if [[ "$FORCE_INSTALL" == "true" ]]; then
    log_warn "Force mode: selected modules will be reinstalled."
fi

# ─── Pre-flight checks ─────────────────────────────────────────────────────

require_linux
require_debian_based
require_not_root

if ! is_installed whiptail; then
    log_info "Installing whiptail..."
    sudo apt install -y whiptail
fi

# ─── Interactive module selection ───────────────────────────────────────────

# When --force is used, default everything to OFF so the user picks what to reinstall
if [[ "$FORCE_INSTALL" == "true" ]]; then
    DEFAULT=OFF
    TITLE="Settings Installer (FORCE REINSTALL)"
else
    DEFAULT=ON
    TITLE="Settings Installer"
fi

CHOICES=$(whiptail --title "$TITLE" \
    --checklist "Select components to install:" 30 72 19 \
    "core-apt"      "Core tools (vim, wget, curl, git, gpg)"       $DEFAULT \
    "fun"           "Fun terminal (fortune, cowsay, lolcat)"        $DEFAULT \
    "fastfetch"     "Fastfetch (system info display)"               $DEFAULT \
    "nerd-fonts"    "Nerd Fonts (Agave, Hack, RobotoMono, etc.)"   $DEFAULT \
    "oh-my-zsh"     "Oh My Zsh + Powerlevel10k theme"               OFF \
    "gnome-tweaks"  "GNOME Tweaks + Browser Connector"              $DEFAULT \
    "gnome-boxes"   "GNOME Boxes (virtualisation)"                  OFF \
    "vscode"        "Visual Studio Code (Microsoft apt repo)"       $DEFAULT \
    "dotnet"        ".NET SDK (official install script)"            OFF \
    "powershell"    "PowerShell (Microsoft apt repo)"               OFF \
    "dart"          "Dart SDK (Google apt repo)"                    OFF \
    "github-cli"    "GitHub CLI (gh)"                               $DEFAULT \
    "uv"            "uv - Python package manager (Astral)"          $DEFAULT \
    "claude-code"   "Claude Code CLI"                               OFF \
    "peon-ping"     "Peon Ping (AI agent audio notifications)"      OFF \
    "doc-tools"     "Document processing (pandoc, texlive)"         $DEFAULT \
    "obsidian"      "Obsidian (AppImage)"                           OFF \
    "telegram"      "Telegram (Flatpak)"                            OFF \
    "spotify"       "Spotify (Snap)"                                OFF \
    3>&1 1>&2 2>&3)

# User cancelled
if [[ $? -ne 0 ]]; then
    log_info "Installation cancelled."
    exit 0
fi

# ─── Run selected modules ──────────────────────────────────────────────────

SUCCEEDED=()
FAILED=()

for module in $CHOICES; do
    # Strip quotes added by whiptail
    module="${module//\"/}"
    if run_module "$module"; then
        SUCCEEDED+=("$module")
    else
        FAILED+=("$module")
    fi
done

# ─── Configure shell ───────────────────────────────────────────────────────

log_step "Configuring shell..."
bash "$SETUP_DIR/configure-shell.sh"

# ─── Summary ────────────────────────────────────────────────────────────────

echo ""
echo "============================================================"
echo "  Installation complete!"
echo "============================================================"

if [[ ${#SUCCEEDED[@]} -gt 0 ]]; then
    log_info "Succeeded: ${SUCCEEDED[*]}"
fi

if [[ ${#FAILED[@]} -gt 0 ]]; then
    log_warn "Failed: ${FAILED[*]}"
fi

echo ""
log_info "Open a new terminal or run 'exec -l \$SHELL' to apply changes."
