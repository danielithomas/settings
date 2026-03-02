# Settings

Personal dotfiles and environment bootstrap repo for Debian-based Linux (Ubuntu, Pop!_OS, etc.) and WSL. Clone into `~/settings` on a fresh machine and run the interactive installer.

## Quick Start

```bash
git clone https://github.com/danielithomas/settings.git ~/settings
bash ~/settings/setup/install.sh
```

The installer uses a whiptail checklist to let you pick which components to install. It's idempotent — safe to re-run without duplicating config or reinstalling things.

## What Gets Installed

| Component      | Method                          | Default |
|----------------|---------------------------------|---------|
| Core tools     | apt (vim, wget, curl, git, gpg) | ON      |
| Fun terminal   | apt (fortune, cowsay, lolcat)   | ON      |
| Fastfetch      | apt or GitHub .deb              | ON      |
| Nerd Fonts     | GitHub releases (7 default)     | ON      |
| Oh My Zsh      | Install script + Powerlevel10k  | OFF     |
| GNOME Tweaks   | apt                             | ON      |
| GNOME Boxes    | apt                             | OFF     |
| VS Code        | Microsoft apt repo              | ON      |
| .NET SDK       | Official install script         | OFF     |
| PowerShell     | Microsoft apt repo              | OFF     |
| Dart SDK       | Google apt repo                 | OFF     |
| uv             | Astral install script           | ON      |
| Claude Code    | npm (auto-installs Node.js)     | OFF     |
| Obsidian       | AppImage from GitHub            | OFF     |
| Telegram       | Flatpak                         | OFF     |
| Spotify        | Flatpak                         | OFF     |

## What You Get at Runtime

After installation, every new shell session gives you:

- A fortune/cowsay/lolcat greeting
- Handy aliases (`makepass`, `backup-shell`, `reload-shell`, `help-me`)
- Python/uv aliases (`create-env`, `activate-env`, `uv-init`, `uv-sync`)
- `install-nerd-font <Name>` to install additional Nerd Fonts on demand
- PATH setup for .NET, uv, and local bins

Type `help-me` in any terminal for the full alias list.

## Repository Structure

```
setup/
  install.sh              # Interactive installer (entry point)
  lib.sh                  # Shared library (logging, helpers)
  configure-shell.sh      # Idempotent .bashrc/.zshrc config injection
  config/shell-config.sh  # Shell config template
  modules/                # One script per installable component
scripts/
  shell-init.sh           # Runtime entry point (sourced from RC file)
  lib/                    # Aliases, shell-launch greeting, backup
  help/                   # Help system
```

## Shell Config

The installer injects a config block into your `.bashrc` (or `.zshrc`) wrapped in sentinel markers:

```
# >>> settings-repo-config >>>
... config ...
# <<< settings-repo-config <<<
```

Re-running the installer replaces the block in-place rather than appending duplicates.

## Running Individual Modules

Each module works standalone:

```bash
bash ~/settings/setup/modules/vscode.sh
```
