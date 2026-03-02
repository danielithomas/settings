#!/bin/bash
# Install a Nerd Font by name from GitHub releases.
# Usage: bash install-nerd-font.sh <FontName> [FontName2 ...]
# Example: bash install-nerd-font.sh Lekton
#          bash install-nerd-font.sh Agave Hack RobotoMono

FONT_DIR="$HOME/.local/share/fonts"

_lol() {
    if command -v lolcat &>/dev/null; then
        lolcat
    else
        cat
    fi
}

install_nerd_font() {
    local name="$1"
    local target_dir="$FONT_DIR/$name"

    if [[ -d "$target_dir" ]] && ls "$target_dir"/*.ttf &>/dev/null 2>&1; then
        echo "  >> $name Nerd Font already installed, skipping." | _lol
        return 0
    fi

    echo "  >> Downloading $name Nerd Font..." | _lol

    local latest_tag
    latest_tag="$(curl -fsSL https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest \
        | grep '"tag_name"' | head -1 | cut -d '"' -f 4)"

    if [[ -z "$latest_tag" ]]; then
        echo "  >> ERROR: Could not determine latest Nerd Fonts release." | _lol
        return 1
    fi

    local url="https://github.com/ryanoasis/nerd-fonts/releases/download/${latest_tag}/${name}.zip"
    local tmp_zip
    tmp_zip="$(mktemp /tmp/nerd-font-${name}-XXXXXX.zip)"

    if ! curl -fsSL -o "$tmp_zip" "$url"; then
        echo "  >> ERROR: Failed to download $name. Check the font name is correct." | _lol
        echo "  >> Browse available fonts at: https://www.nerdfonts.com/font-downloads" | _lol
        rm -f "$tmp_zip"
        return 1
    fi

    mkdir -p "$target_dir"
    unzip -qo "$tmp_zip" -d "$target_dir"
    rm -f "$tmp_zip"

    echo "  >> $name Nerd Font installed to $target_dir" | _lol
}

# ─── Main ───────────────────────────────────────────────────────────────────

if [[ $# -eq 0 ]]; then
    echo "Usage: install-nerd-font <FontName> [FontName2 ...]" | _lol
    echo "Example: install-nerd-font Lekton" | _lol
    echo "Browse fonts: https://www.nerdfonts.com/font-downloads" | _lol
    exit 1
fi

echo "Nerd Font Installer >>>" | _lol

for font in "$@"; do
    install_nerd_font "$font"
done

# Refresh font cache
echo "  >> Refreshing font cache..." | _lol
fc-cache -f
echo "  >> Done!" | _lol

unset -f _lol
