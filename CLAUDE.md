# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

Personal dotfiles and environment bootstrap repo for Debian-based Linux and WSL. Cloned into `~/settings` on target machines.

## Architecture

Two top-level directories:

- **`setup/`** — One-time installation scripts. Entry point: `setup/install.sh` (interactive whiptail UI). Modular design with one script per component in `setup/modules/`.
- **`scripts/`** — Runtime shell scripts sourced on every shell launch. Entry point: `scripts/shell-init.sh`, which loads aliases from `scripts/lib/`.

### Setup flow

`install.sh` → whiptail checklist → `run_module()` for each selected module → `configure-shell.sh` (idempotent config injection via sentinel markers)

### Runtime flow (every shell open)

`.bashrc`/`.zshrc` (via injected config block) → sets `$CUST_SCRIPTS` → sources `shell-init.sh` → sources aliases → runs `shell-launch.sh` (fortune/cowsay greeting)

### Key environment variables

- `$CUST_SCRIPTS` — points to `~/settings/scripts`, used by all alias and help scripts
- `$CUST_CONFIG` — points to `~/config` (created automatically by installer)

## Conventions

- All scripts are bash (`#!/bin/bash`). No build system, linter, or test suite.
- Linux-only (Debian-based). No Mac support.
- Install modules are idempotent — they check if software is already installed and skip if so.
- Shell config injection uses sentinel markers (`# >>> settings-repo-config >>>` / `# <<< settings-repo-config <<<`) to allow safe re-runs.
- The repo is expected to live at `~/settings`.
- Shared utilities live in `setup/lib.sh` (logging, OS checks, `run_module()`, `ensure_flatpak()`, `inject_config()`).
- No snaps. Apps use apt repos, Flatpak, AppImage, or official install scripts.
