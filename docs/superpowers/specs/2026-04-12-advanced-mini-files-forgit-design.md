# Advanced Mini.files & Forgit Integration Design

**Date:** 2026-04-12
**Topic:** Neovim File Explorer & Zsh Git Interactive Tools
**Status:** Approved

## 1. Goal
Implement a high-performance interactive file explorer in Neovim (`mini.files`) and a powerful Git TUI in Zsh (`forgit`) to enhance navigation and version control.

## 2. Current State Analysis
- **Neovim:** `mini.files` is partially configured but lacks advanced Git status icons and project-specific bookmarks.
- **Zsh:** Using Zinit for performance. Currently lacks `forgit` and advanced FZF-based Git helpers.

## 3. Proposed Architecture

### 3.1 Advanced Mini.files (Neovim)
- **Plugin:** `echasnovski/mini.files` (via LazyVim extra or custom spec).
- **Features:**
    - **Git Status:** Integrate Git status icons (using a custom `Lsp`-like decorator).
    - **Bookmarks:** Add keybindings for rapid navigation:
        - `<leader>fm`: Toggle at current file.
        - `<leader>fd`: Open at `~/dotfiles/`.
        - `<leader>ft`: Open at `~/ax-livia/test/`.
    - **UX:** Column-based floating explorer with full CRUD support (rename, create, delete as text edits).

### 3.2 Forgit & FZF (Zsh)
- **Plugin:** `wfxr/forgit` (installed via Zinit Turbo Mode).
- **Aliases:**
    - `ga`: Interactive `git add` with preview.
    - `gd`: Interactive `git diff` with syntax-highlighted preview.
    - `gl`: Interactive `git log` with commit graph and preview.
    - `gr`: Interactive `git reset`.
- **FZF Helpers:**
    - Branch switcher (`fbr`) and stash previewer (`fsh`).
    - Use `bat` for syntax highlighting in previews.

## 4. Implementation Details
- **Neovim:** Update `lua/plugins/mini-files.lua` with advanced opts and keymaps.
- **Zsh:** Add `zinit ice wait'0' lucid; zinit light wfxr/forgit` to `.zshrc`.
- **Performance:** All Zsh tools will be lazy-loaded using Zinit Turbo Mode to maintain < 0.4s startup time.

## 5. Success Criteria
- Instant access to `mini.files` with Git indicators in Neovim.
- Interactive Git tools (`ga`, `gd`, etc.) available in Zsh with zero startup lag.
- Seamless navigation between project-specific directories.

