# Shell configuration injected by ~/settings/setup/configure-shell.sh
# Works in both bash and zsh

# ─── Environment ────────────────────────────────────────────────────────────

export CUST_CONFIG="$HOME/config"
export CUST_SCRIPTS="$HOME/settings/scripts"

# ─── PATH additions ────────────────────────────────────────────────────────

# .NET SDK
if [ -d "$HOME/.dotnet" ]; then
    export DOTNET_ROOT="$HOME/.dotnet"
    export PATH="$PATH:$HOME/.dotnet:$HOME/.dotnet/tools"
fi

# uv (Python manager)
if [ -d "$HOME/.local/bin" ]; then
    export PATH="$PATH:$HOME/.local/bin"
fi

# ─── Aliases ────────────────────────────────────────────────────────────────

alias python=python3

# ─── Source runtime scripts ─────────────────────────────────────────────────

if [ -f "$CUST_SCRIPTS/shell-init.sh" ]; then
    source "$CUST_SCRIPTS/shell-init.sh"
fi

# ─── Shell greeting ─────────────────────────────────────────────────────────

if [ -f "$CUST_SCRIPTS/lib/shell-launch.sh" ]; then
    source "$CUST_SCRIPTS/lib/shell-launch.sh" stegosaurus
fi
