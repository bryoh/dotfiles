# FZF Update Design (0.60.0+)

**Date:** 2026-04-12
**Topic:** FZF version update for Forgit compatibility
**Status:** Approved

## 1. Goal
Update `fzf` to version 0.60.0 or higher to ensure compatibility with `forgit` and other modern Zsh plugins.

## 2. Current State Analysis
- **Version:** 0.44.1 (installed via `apt`).
- **Location:** `/usr/bin/fzf`.
- **Problem:** `forgit` and custom FZF helpers require 0.60.0+.

## 3. Proposed Architecture

### 3.1 Installation Mechanism
- **Tool:** Official `fzf` git installer.
- **Path:** `~/.fzf`.
- **Binary Path:** `~/.fzf/bin/fzf` (added to `PATH`).

### 3.2 Shell Integration
- The installer adds completions and keybindings to `.zshrc`.
- Since we already have a custom `.zshrc`, we'll ensure the installer's changes are correctly integrated or manually added to our managed dotfiles.

## 4. Implementation Details
- **Command:**
    ```bash
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all --no-update-rc
    ```
- **Symlink:** We'll ensure `~/.local/bin/fzf` points to the new version if needed, or rely on the updated `PATH`.

## 5. Success Criteria
- `fzf --version` reports 0.60.0 or higher.
- `forgit` and custom FZF functions (`fbr`, `fsh`) work without version errors.

