# Neovim Clipboard Fix Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Restore Neovim clipboard functionality using the native OSC 52 provider for reliable SSH/Tmux syncing.

**Architecture:** Switch from custom manual implementation to Neovim's built-in `vim.ui.clipboard.osc52` module.

**Tech Stack:** Lua, Neovim (v0.12.0).

---

### Task 1: Migrate to Native OSC 52 Provider

**Files:**
- Modify: `nvim/.config/nvim/lua/config/options.lua`

- [ ] **Step 1: Replace custom implementation**
Find the previous clipboard block and replace it with the simplified native implementation:
```lua
-- OSC 52 clipboard support (SSH + Tmux compatible)
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

- [ ] **Step 2: Commit**
Run: `git add nvim/.config/nvim/lua/config/options.lua && git commit -m "fix: switch to native nvim osc52 clipboard provider"`

---

### Task 2: Final Verification

- [ ] **Step 1: Restart Neovim**
Fully exit and restart Neovim to ensure the provider is initialized.
- [ ] **Step 2: Test Yanking**
Yank a line (`yy`) and verify it's in your local machine's clipboard.
