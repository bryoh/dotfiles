# Neovim OSC 52 Tmux Fix Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Enable Neovim's OSC 52 clipboard provider to work correctly when running inside a Tmux session over SSH.

**Architecture:** Custom clipboard provider in Neovim that handles Tmux passthrough sequences.

**Tech Stack:** Lua, Neovim (v0.12.0), Tmux.

---

### Task 1: Update OSC 52 Clipboard Provider for Tmux

**Files:**
- Modify: `nvim/.config/nvim/lua/config/options.lua`

- [ ] **Step 1: Replace the previous OSC 52 logic**
Replace the previous clipboard block with a more robust implementation that handles Tmux passthrough:
```lua
-- OSC 52 clipboard support (SSH + Tmux compatible)
if vim.env.SSH_TTY or vim.env.SSH_CONNECTION or vim.env.TMUX then
  vim.opt.clipboard = "unnamedplus"

  local function copy(lines, _)
    local s = table.concat(lines, "\n")
    local b64 = vim.fn.system("base64 | tr -d '\n'", s)
    local osc = "\x1b]52;c;" .. b64 .. "\x07"
    if vim.env.TMUX then
      osc = "\x1bPtmux;\x1b" .. osc .. "\x1b\"
    end
    io.stdout:write(osc)
  end

  local function paste()
    return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
  end

  vim.g.clipboard = {
    name = "OSC 52",
    copy = { ["+"] = copy, ["*"] = copy },
    paste = { ["+"] = paste, ["*"] = paste },
  }
end
```

- [ ] **Step 2: Commit**
Run: `git add nvim/.config/nvim/lua/config/options.lua && git commit -m "fix: update nvim osc52 for tmux compatibility"`

---

### Task 2: Verification

- [ ] **Step 1: Test Yanking in Tmux**
Run Neovim inside Tmux over SSH, yank some text (`yy`), and try to paste it into an application on your local machine.
Expected: The text is pasted successfully.

- [ ] **Step 2: Test Yanking Outside Tmux (Optional)**
If possible, run Neovim outside Tmux over SSH and verify that it still works.
