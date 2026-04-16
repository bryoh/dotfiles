# Automatic NVM Stubber Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement a dynamic loop in Zsh that automatically generates lazy-loading stubs for all installed Node packages.

**Architecture:** Directory scanning for binaries with dynamic `eval` function generation.

**Tech Stack:** Zsh, NVM.

---

### Task 1: Refactor NVM Lazy-Loading in Zshrc

**Files:**
- Modify: `zsh/.zshrc`

- [ ] **Step 1: Implement Dynamic Stubber**
Replace the hardcoded stubs (`nvm()`, `node()`, etc.) with the following loop:
```zsh
# Automatic NVM & Node Package Stubber
export NVM_DIR="$HOME/.nvm"

zsh-defer-nvm() {
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}

# Dynamically find the binary path and create stubs
() {
  local default_node
  default_node=$(cat "$NVM_DIR/alias/default" 2>/dev/null)
  [[ -z "$default_node" ]] && default_node="lts/*"
  
  local nvm_bin
  nvm_bin=$(ls -d $NVM_DIR/versions/node/v*/bin 2>/dev/null | tail -n 1)
  
  if [[ -d "$nvm_bin" ]]; then
    local cmds=($(ls "$nvm_bin"))
    cmds+=("nvm") # Always include nvm
    
    for cmd in ${cmds}; do
      eval "$cmd() { unfunction ${cmds}; zsh-defer-nvm; $cmd \"\$@\" }"
    done
  fi
}
```

- [ ] **Step 2: Remove old stubs**
Ensure the hardcoded `nvm()`, `node()`, `npm()`, `yarn()`, and `gemini()` functions are deleted.

- [ ] **Step 3: Commit**
Run: `git add zsh/.zshrc && git commit -m "perf: implement dynamic nvm auto-stubber"`

---

### Task 2: Verification

- [ ] **Step 1: Verify Startup Speed**
Run: `/usr/bin/time -f "%e" zsh -i -c exit`
Expected: < 0.45s

- [ ] **Step 2: Verify Lazy Loading**
Run: `which gemini`
Expected: Path to gemini is found after the first call.
Run: `which node`
Expected: Path to node is found.
