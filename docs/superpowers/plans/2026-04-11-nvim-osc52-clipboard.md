# Neovim OSC 52 Clipboard Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Enable Neovim's built-in OSC 52 clipboard provider to sync yanks over SSH to the local system clipboard.

**Architecture:** Conditional clipboard provider configuration in Neovim options.

**Tech Stack:** Lua, Neovim (v0.12.0).

---

### Task 1: Configure OSC 52 Clipboard Provider

**Files:**
- Modify: `nvim/.config/nvim/lua/config/options.lua`

- [ ] **Step 1: Append OSC 52 configuration**
Add the following code to the end of `nvim/.config/nvim/lua/config/options.lua`:
```lua

-- Enable OSC 52 clipboard support for SSH sessions
-- This allows Neovim to update the local system clipboard via the terminal emulator
vim.opt.clipboard = "unnamedplus"
if vim.env.SSH_TTY or vim.env.SSH_CONNECTION then
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
Run: `git add nvim/.config/nvim/lua/config/options.lua && git commit -m "feat: enable nvim osc52 clipboard sync over ssh"`

---

### Task 2: Verification

- [ ] **Step 1: Test Yanking**
Open a file in Neovim on the remote machine, yank some text (`yy`), and try to paste it into an application on your local machine.
Expected: The text is pasted successfully.

- [ ] **Step 2: Verify Log (if needed)**
If it fails, check if the terminal emulator supports OSC 52 (e.g., iTerm2, Alacritty, Kitty, Windows Terminal).
