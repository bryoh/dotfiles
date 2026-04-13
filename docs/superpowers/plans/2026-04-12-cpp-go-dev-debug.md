# C++ and Go Development & Debugging Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Enable C++ and Go development and debugging in Neovim with unified keybindings and UI, matching the Python workflow.

**Architecture:** Use Mason for tool management, lspconfig for server setup, and nvim-dap for debugging.

**Tech Stack:** Lua, Neovim (v0.12.0), Mason, clangd, gopls, delve, codelldb.

---

### Task 1: Enable C++ and Go LSP (lspconfig)

**Files:**
- Modify: `nvim/.config/nvim/lua/plugins/lsp/lspconfig.lua`

- [ ] **Step 1: Update Mason ensure_installed**
Add `clangd` and `gopls` to the `ensure_installed` list in `require("mason-lspconfig").setup`.
- [ ] **Step 2: Uncomment and update clangd setup**
Uncomment the `lspconfig.clangd.setup` block and ensure it uses the correct `on_attach` and `capabilities`.
- [ ] **Step 3: Uncomment gopls setup**
Uncomment the `setup_lsp("gopls")` line.
- [ ] **Step 4: Commit**
Run: `git add nvim/.config/nvim/lua/plugins/lsp/lspconfig.lua && git commit -m "feat: enable clangd and gopls LSP"`

---

### Task 2: Enable Go Debugging (dap.lua)

**Files:**
- Modify: `nvim/.config/nvim/lua/plugins/lsp/dap.lua`

- [ ] **Step 1: Add nvim-dap-go dependency**
Add `"leoluz/nvim-dap-go"` to the dependencies of the `"mfussenegger/nvim-dap"` plugin.
- [ ] **Step 2: Configure nvim-dap-go**
Add `require("dap-go").setup()` inside the `config` function of `nvim-dap`.
- [ ] **Step 3: Update Mason ensure_installed**
Add `delve` to the `ensure_installed` list in `require("mason-nvim-dap").setup`.
- [ ] **Step 4: Commit**
Run: `git add nvim/.config/nvim/lua/plugins/lsp/dap.lua && git commit -m "feat: enable go debugging with delve and nvim-dap-go"`

---

### Task 3: Refine C++ Debugging (dap.lua)

**Files:**
- Modify: `nvim/.config/nvim/lua/plugins/lsp/dap.lua`

- [ ] **Step 1: Update codelldb path**
Ensure the `codelldb` adapter uses the correct path to the Mason-installed binary.
- [ ] **Step 2: Add C++ debug configuration**
Add a standard `codelldb` configuration for C++ to `dap.configurations.cpp`.
- [ ] **Step 3: Commit**
Run: `git add nvim/.config/nvim/lua/plugins/lsp/dap.lua && git commit -m "feat: refine cpp debugging with codelldb"`

---

### Task 4: Final Verification

- [ ] **Step 1: Verify LSP**
Open a C++ file and a Go file to ensure definitions and references work.
- [ ] **Step 2: Verify Debugging**
Set a breakpoint in a simple C++ and Go program and use `<F5>` to start debugging.
Expected: `nvim-dap-ui` opens and debugging proceeds as expected.
