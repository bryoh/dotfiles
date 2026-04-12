# FZF Update Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Update FZF to 0.60.0+ to enable compatibility with modern Zsh plugins.

**Architecture:** Use the official FZF git installer for a local bin installation.

**Tech Stack:** Git, Bash.

---

### Task 1: Install Latest FZF

- [ ] **Step 1: Clone the FZF repository**
Run: `git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf`

- [ ] **Step 2: Run the installer script**
Run: `~/.fzf/install --all --no-update-rc`
Expected: A new `fzf` binary is created in `~/.fzf/bin/`.

- [ ] **Step 3: Symlink to ~/.local/bin**
Run: `mkdir -p ~/.local/bin && ln -sf ~/.fzf/bin/fzf ~/.local/bin/fzf`

- [ ] **Step 4: Verify version**
Run: `~/.local/bin/fzf --version`
Expected: Output showing 0.60.0 or higher.

---

### Task 2: Verify Integration

- [ ] **Step 1: Source ~/.zshrc**
Run: `zsh -i -c "source ~/.zshrc"`

- [ ] **Step 2: Test Forgit**
Run: `zsh -i -c "ga --help"` (Check if Forgit's add help appears without version errors).
Expected: Successful output from Forgit.

- [ ] **Step 3: Test custom functions**
Run: `zsh -i -c "fbr --help"` (or similar).
Expected: No version errors.

