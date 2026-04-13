# C++ and Go Development & Debugging Design

**Date:** 2026-04-12
**Topic:** Unified C++/Go LSP & DAP Setup (Mason-Managed)
**Status:** Approved

## 1. Goal
Implement a complete C++ and Go development and debugging environment in Neovim that matches the existing Python workflow, keybindings, and UI.

## 2. Current State Analysis
- **Editor:** Neovim v0.12.0 with LazyVim.
- **Python:** Fully functional with `pyright` (LSP) and `debugpy` (DAP).
- **C++/Go:** Compilers installed (g++, go), but Neovim config lacks active LSP and DAP setup.
- **DAP Keybindings:** Using `<localleader>d` and Function keys (`F5`, `F7`, `F8`).

## 3. Proposed Architecture

### 3.1 Language Support (LSP)
- **C++:** Enable `clangd` via Mason.
- **Go:** Enable `gopls` via Mason.
- **Build Systems:** Enable `cmake` support.

### 3.2 Debugging (DAP)
- **C++:** Use `codelldb` via Mason.
- **Go:** Use `delve` (dlv) via Mason and `leoluz/nvim-dap-go` for zero-config debugging.
- **Unified UI:** Use `nvim-dap-ui` (already configured) for all languages.

### 3.3 Unified Keybindings
- All debugging actions (breakpoints, continue, step) will use the existing `<localleader>d` and F-keys for all three languages (Python, Go, C++).
- All LSP actions (definitions, references, rename) will use the existing mappings (`gd`, `gr`, `<leader>rn`).

## 4. Implementation Details
- **LSP:** Update `nvim/.config/nvim/lua/plugins/lsp/lspconfig.lua` to uncomment/configure `clangd` and add `gopls`.
- **DAP:** 
    - Update `nvim/.config/nvim/lua/plugins/lsp/dap.lua` to add `nvim-dap-go`.
    - Ensure `codelldb` is correctly configured for C++.
    - Add `delve` to Mason's `ensure_installed`.

## 5. Success Criteria
- Instant definition/reference lookup in C++ and Go files.
- Debugging (F5 to continue, F8 to step over) works identically for C++, Go, and Python.
- `nvim-dap-ui` correctly opens and shows variables/stack for all three languages.

