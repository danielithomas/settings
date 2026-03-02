#!/bin/bash
# Module: Oh My Zsh + Powerlevel10k theme

SETUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$SETUP_DIR/lib.sh"

# Ensure zsh is installed
if ! is_installed zsh; then
    log_info "Installing zsh..."
    sudo apt install -y zsh
fi

# Install Oh My Zsh
if [[ "${FORCE_INSTALL:-}" == "true" ]]; then
    log_info "Force reinstalling Oh My Zsh..."
    rm -rf "$HOME/.oh-my-zsh"
    RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
elif [[ -d "$HOME/.oh-my-zsh" ]]; then
    log_info "Oh My Zsh is already installed, skipping."
else
    log_info "Installing Oh My Zsh..."
    RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install Powerlevel10k theme
P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if [[ "${FORCE_INSTALL:-}" == "true" ]]; then
    log_info "Force reinstalling Powerlevel10k theme..."
    rm -rf "$P10K_DIR"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
elif [[ -d "$P10K_DIR" ]]; then
    log_info "Powerlevel10k is already installed, skipping."
else
    log_info "Installing Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
fi

# Set ZSH_THEME in .zshrc (always applied, not affected by --force)
if [[ -f "$HOME/.zshrc" ]]; then
    if grep -q 'ZSH_THEME="powerlevel10k/powerlevel10k"' "$HOME/.zshrc"; then
        log_info "Powerlevel10k theme already set in .zshrc"
    else
        log_info "Setting Powerlevel10k as ZSH_THEME in .zshrc"
        sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' "$HOME/.zshrc"
    fi
fi

log_info "Oh My Zsh + Powerlevel10k installed."
log_info "Run 'chsh -s \$(which zsh)' to make zsh your default shell."
log_info "Open a new terminal to run the Powerlevel10k configuration wizard."
