# Advanced Mini.files & Forgit Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement a high-performance interactive file explorer in Neovim (`mini.files`) and a powerful Git TUI in Zsh (`forgit`).

**Architecture:** Advanced configuration for `mini.files` and Turbo Mode Zinit loading for `forgit`.

**Tech Stack:** Lua, Zsh, Zinit, FZF.

---

### Task 1: Advanced Mini.files Configuration (Neovim)

**Files:**
- Modify: `nvim/.config/nvim/lua/plugins/mini-files.lua`

- [ ] **Step 1: Update the plugin configuration**
Update `nvim/.config/nvim/lua/plugins/mini-files.lua` with advanced mappings and keybindings:
```lua
return {
  "echasnovski/mini.files",
  opts = {
    mappings = {
      go_in_plus = "L",
      go_out_plus = "H",
      scroll_preview_down = "<C-d>",
      scroll_preview_up = "<C-u>",
    },
    windows = {
      preview = true,
      width_preview = 90,
    },
  },
  keys = {
    { "<leader>fm", function() require("mini.files").open(vim.api.nvim_buf_get_name(0), true) end, desc = "Open mini.files (Directory of Current File)" },
    { "<leader>fM", function() require("mini.files").open(vim.uv.cwd(), true) end, desc = "Open mini.files (CWD)" },
    { "<leader>fd", function() require("mini.files").open(vim.fn.expand("~/dotfiles"), true) end, desc = "Open mini.files at ~/dotfiles" },
    { "<leader>ft", function() require("mini.files").open(vim.fn.expand("~/ax-livia/test"), true) end, desc = "Open mini.files at ~/ax-livia/test" },
  },
}
```

- [ ] **Step 2: Commit**
Run: `git add nvim/.config/nvim/lua/plugins/mini-files.lua && git commit -m "feat: advanced mini.files config with project bookmarks"`

---

### Task 2: Forgit & FZF Integration (Zsh)

**Files:**
- Modify: `zsh/.zshrc`

- [ ] **Step 1: Add Forgit to Zinit**
Add the following to the plugin section of `zsh/.zshrc`:
```zsh
# Forgit (Interactive Git with FZF)
zinit ice wait'0' lucid
zinit light wfxr/forgit
```

- [ ] **Step 2: Add custom FZF Git helpers**
Add these functions to the end of `zsh/.zshrc`:
```zsh
# Fuzzy checkout branch (fbr)
fbr() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# Fuzzy stash preview (fsh)
fsh() {
  local stash
  stash=$(git stash list | fzf +m --preview 'git stash show --color=always {1}') &&
  git stash apply $(echo "$stash" | cut -d: -f1)
}
```

- [ ] **Step 3: Commit**
Run: `git add zsh/.zshrc && git commit -m "feat: add forgit and custom fzf git helpers to zsh"`

---

### Task 3: Final Verification

- [ ] **Step 1: Test Neovim keybindings**
Verify that `<leader>fm`, `<leader>fd`, and `<leader>ft` work as expected.
- [ ] **Step 2: Test Zsh forgit aliases**
Verify that `ga`, `gd`, and `gl` (from forgit) and our custom `fbr`/`fsh` are functional.
