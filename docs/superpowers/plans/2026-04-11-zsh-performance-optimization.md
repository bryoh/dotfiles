# Zsh Performance Optimization Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Reduce Zsh startup from 0.93s to < 0.2s by migrating from Antigen to Zinit and lazy-loading virtualenvwrapper.

**Architecture:** Parallel and background loading using Zinit's Turbo Mode.

**Tech Stack:** Zsh, Zinit, Powerlevel10k.

---

### Task 1: Environment Backup & Zinit Installation

**Files:**
- Create: `zsh/.zshrc.bak`
- Modify: `zsh/.zshrc`

- [ ] **Step 1: Backup current config**
Run: `cp zsh/.zshrc zsh/.zshrc.bak`

- [ ] **Step 2: Install Zinit**
Run: `bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"`

- [ ] **Step 3: Verify Zinit directory**
Run: `ls -d ~/.local/share/zinit/bin`
Expected: Directory exists.

- [ ] **Step 4: Commit**
Run: `git add zsh/.zshrc.bak && git commit -m "feat: backup zshrc and install zinit"`

---

### Task 2: Port Core Configuration (P10k & Zinit Init)

**Files:**
- Modify: `zsh/.zshrc`

- [ ] **Step 1: Replace Antigen init with Zinit init**
Replace the Antigen source lines with:
```zsh
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Zinit bootstrap
if [[ ! -f $HOME/.local/share/zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}D%F{220}HAMA %F{33}Zinit %F{220}(zinit.zsh)...%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ %F{160}The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
```

- [ ] **Step 2: Verify prompt still loads**
Run: `zsh -i -c exit`
Expected: No errors, p10k loaded.

- [ ] **Step 3: Commit**
Run: `git add zsh/.zshrc && git commit -m "feat: migrate init logic to zinit"`

---

### Task 3: Port Antigen Bundles to Zinit (Turbo Mode)

**Files:**
- Modify: `zsh/.zshrc`

- [ ] **Step 1: Replace Antigen bundle calls with Zinit wait/light**
Replace antigen bundle lines with:
```zsh
# Load Oh-My-Zsh library
zinit snippet OMZ::lib/completion.zsh
zinit snippet OMZ::lib/history.zsh

# Load bundles in background (Turbo Mode)
zinit ice wait'0' lucid
zinit light zsh-users/zsh-autosuggestions

zinit ice wait'0' lucid
zinit light zsh-users/zsh-syntax-highlighting

zinit ice wait'1' lucid
zinit light zsh-users/zsh-completions

# Port existing antigen bundles
zinit ice wait'2' lucid
zinit snippet OMZ::plugins/git
zinit ice wait'2' lucid
zinit snippet OMZ::plugins/pip
zinit ice wait'2' lucid
zinit snippet OMZ::plugins/docker-compose
```

- [ ] **Step 2: Remove antigen apply**
Delete: `antigen apply`

- [ ] **Step 3: Commit**
Run: `git add zsh/.zshrc && git commit -m "feat: port bundles to zinit turbo mode"`

---

### Task 4: Optimize Python virtualenvwrapper

**Files:**
- Modify: `zsh/.zshrc`

- [ ] **Step 1: Implement lazy-loading for virtualenvwrapper**
Replace the existing virtualenvwrapper loop with:
```zsh
# Lazy-load virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=$(command -v python3)

zsh-defer-virtualenvwrapper() {
  local venv_sh="/usr/share/virtualenvwrapper/virtualenvwrapper.sh"
  [[ -r "$venv_sh" ]] || venv_sh="$(command -v virtualenvwrapper.sh)"
  if [[ -n "$venv_sh" ]]; then
    source "$venv_sh"
  fi
}

# Create stubs that load the real thing on first use
workon() { unfunction workon mkvirtualenv; zsh-defer-virtualenvwrapper; workon "$@" }
mkvirtualenv() { unfunction workon mkvirtualenv; zsh-defer-virtualenvwrapper; mkvirtualenv "$@" }
```

- [ ] **Step 2: Run benchmark**
Run: `/usr/bin/time -f "%e" zsh -i -c exit`
Expected: < 0.25s

- [ ] **Step 3: Commit**
Run: `git add zsh/.zshrc && git commit -m "perf: lazy-load virtualenvwrapper"`

