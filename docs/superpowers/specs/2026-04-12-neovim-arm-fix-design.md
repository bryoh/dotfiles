# Neovim ARM64 LSP & Plugin Fix Design

**Date:** 2026-04-12
**Topic:** Resolving Clangd and Mini.files issues on ARM64
**Status:** Approved

## 1. Goal
Resolve the "unsupported platform" error for `clangd` and the plugin rename warning for `mini.files`.

## 2. Current State Analysis
- **mini.files:** Renamed to `nvim-mini/mini.files` in LazyVim.
- **clangd:** Mason installation fails on ARM64. Neovim attempts to spawn it but fails because it's missing.
- **gopls/codelldb:** Successfully installed via Mason.

## 3. Proposed Architecture

### 3.1 Plugin Fix
- **Action:** Update `nvim/.config/nvim/lua/plugins/mini-files.lua` to use the new repository name. (Already partially completed).

### 3.2 Clangd Fix (System Fallback)
- **Action:** Install `clangd` via the system package manager.
- **Action:** Remove `clangd` from Mason's `ensure_installed` list to prevent repetitive failure messages.
- **Action:** Ensure `lspconfig` points to the system `clangd`.

## 4. Implementation Details
- **System Command:** `sudo apt-get install -y clangd` (User may need to run this if I lack permissions, but I'll try).
- **Config Update:**
    - `lspconfig.lua`: Remove `clangd` from `mason-lspconfig` setup.
    - `lspconfig.lua`: Keep the `lspconfig.clangd.setup` call as it will find the binary in the system PATH.

## 5. Success Criteria
- Neovim starts without `mini.files` warnings.
- `clangd` spawns successfully when opening a C++ file.
- Mason no longer reports installation failures.

