# Neovim OSC 52 Clipboard Design (SSH Sync)

**Date:** 2026-04-11
**Topic:** Neovim & Tmux Clipboard Sync over SSH
**Status:** Approved

## 1. Goal
Make Neovim's yank behavior work like Tmux's copy behavior over SSH. This ensures that yanking in Neovim on a remote machine updates the local system clipboard.

## 2. Current State Analysis
- **Tmux:** Using `tmux-yank` with OSC 52 support (works).
- **Neovim:** Running v0.12.0. Clipboard is currently not configured to use OSC 52, causing yanks to stay within the remote session.

## 3. Proposed Architecture

### 3.1 Mechanism: OSC 52
- **OSC 52** is a terminal escape sequence that instructs the terminal emulator (like iTerm2, Alacritty, or Windows Terminal) to update the *local* system clipboard with the provided text.
- Since Neovim v0.10.0, there is a built-in OSC 52 clipboard provider.

### 3.2 Implementation: Neovim Configuration
- **File:** `nvim/.config/nvim/lua/config/options.lua`
- **Action:** Set `vim.opt.clipboard = "unnamedplus"` (to use the system clipboard for all yanks).
- **Action:** Configure the `vim.g.clipboard` provider to use OSC 52.

## 4. Implementation Details
- **Provider Setup:**
    ```lua
    vim.opt.clipboard = "unnamedplus"
    if vim.fn.has("ssh") == 1 then
      vim.g.clipboard = {
        name = "OSC 52",
        copy = {
          ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
          ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
        },
        paste = {
          ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
          ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
        },
      }
    end
    ```

## 5. Success Criteria
- Yanking text in Neovim over SSH (e.g., `yy` or `v + y`) updates the local machine's clipboard.
- No impact on local (non-SSH) Neovim performance.

