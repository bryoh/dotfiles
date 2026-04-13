# Neovim ARM64 Fix Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Resolve the `mini.files` rename warning and fix the `clangd` installation failure on ARM64.

**Architecture:** Use the system package manager for `clangd` and update Neovim config to match.

**Tech Stack:** Lua, Neovim, APT.

---

### Task 1: Install System Clangd

- [ ] **Step 1: Install clangd via apt**
Run: `sudo apt-get update && sudo apt-get install -y clangd`
Expected: `clangd` is available in `/usr/bin/clangd`.

- [ ] **Step 2: Verify installation**
Run: `clangd --version`
Expected: Output showing version information.

---

### Task 2: Update Neovim Config (LSP)

**Files:**
- Modify: `nvim/.config/nvim/lua/plugins/lsp/lspconfig.lua`

- [ ] **Step 1: Remove clangd from Mason ensure_installed**
Find the `mason-lspconfig` setup and remove `"clangd"` from the `ensure_installed` list.
- [ ] **Step 2: Commit**
Run: `git add nvim/.config/nvim/lua/plugins/lsp/lspconfig.lua && git commit -m "fix: remove clangd from mason management and use system binary"`

---

### Task 3: Final Verification

- [ ] **Step 1: Check for startup warnings**
Run: `nvim --headless -c "qa"`
Expected: No `mini.files` warnings.
- [ ] **Step 2: Verify LSP activation**
Open a C++ file (`.cpp`) and check if LSP starts without errors.
Expected: `LspInfo` shows `clangd` is attached.
