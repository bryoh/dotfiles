# Neovim Clipboard Restoration Design

**Date:** 2026-04-12
**Topic:** Fixing Neovim Clipboard Sync over SSH/Tmux
**Status:** Approved

## 1. Goal
Restore Neovim's clipboard synchronization so that yanking text inside Neovim (even inside Tmux over SSH) correctly updates the local system clipboard.

## 2. Current State Analysis
- **Current Setup:** Manual OSC 52 implementation using `io.stdout:write` and shell-outs to `base64`.
- **Problem:** Reporting as "not working," likely due to Neovim's internal UI buffering or shell-out latency in v0.12.0.
- **Environment:** Neovim v0.12.0 (ARM64), Tmux, SSH.

## 3. Proposed Architecture

### 3.1 Mechanism: Built-in OSC 52 Provider
- Neovim v0.10.0+ includes a native `vim.ui.clipboard.osc52` module.
- This module is highly optimized, handles Tmux detection automatically, and avoids shell-out overhead.

### 3.2 Implementation: Neovim Configuration
- **File:** `nvim/.config/nvim/lua/config/options.lua`
- **Action:** Replace the custom logic with calls to the built-in provider.

## 4. Implementation Details
- **Revised Logic:**
    ```lua
    if vim.env.SSH_TTY or vim.env.SSH_CONNECTION or vim.env.TMUX then
      vim.opt.clipboard = "unnamedplus"
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
- Yanking text in Neovim (`yy`) updates the local machine's clipboard instantly.
- No Lua errors on startup.
- Works both inside and outside of Tmux.

