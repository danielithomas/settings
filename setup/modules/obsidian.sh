#!/bin/bash
# Module: Obsidian via AppImage

SETUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$SETUP_DIR/lib.sh"

APPIMAGE_DIR="$HOME/Applications"
APPIMAGE_PATH="$APPIMAGE_DIR/Obsidian.AppImage"
DESKTOP_FILE="$HOME/.local/share/applications/obsidian.desktop"

if [[ "${FORCE_INSTALL:-}" != "true" ]] && [[ -f "$APPIMAGE_PATH" ]]; then
    log_info "Obsidian AppImage already exists, skipping."
    exit 0
fi

log_info "Installing Obsidian AppImage..."

# libfuse2 is required to run AppImages
if ! dpkg -s libfuse2t64 &>/dev/null; then
    log_info "Installing libfuse2t64 (required for AppImage)..."
    sudo apt-get install -y libfuse2t64
fi

# Get latest release URL
LATEST_URL="$(curl -fsSL https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest \
    | grep "browser_download_url.*\.AppImage" \
    | grep -v "arm" \
    | head -1 \
    | cut -d '"' -f 4)"

if [[ -z "$LATEST_URL" ]]; then
    log_error "Could not find Obsidian AppImage download URL."
    exit 1
fi

mkdir -p "$APPIMAGE_DIR"
curl -fsSL -o "$APPIMAGE_PATH" "$LATEST_URL"
chmod +x "$APPIMAGE_PATH"

# Create desktop entry
mkdir -p "$(dirname "$DESKTOP_FILE")"
cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Name=Obsidian
Exec=$APPIMAGE_PATH --no-sandbox
Type=Application
Categories=Office;
Comment=Knowledge base and note-taking
Terminal=false
EOF

log_info "Obsidian installed to $APPIMAGE_PATH"
