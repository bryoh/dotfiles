# P10k Style Cycler Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement an instant Zsh prompt style switcher for Powerlevel10k to visualize Git status differently.

**Architecture:** Symlink-based profile switching with Zsh function-driven re-sourcing.

**Tech Stack:** Zsh, Powerlevel10k.

---

### Task 1: Create Profiles Directory and Initial Styles

**Files:**
- Create: `zsh/p10k_profiles/lean.p10k.zsh`
- Create: `zsh/p10k_profiles/classic.p10k.zsh`
- Create: `zsh/p10k_profiles/rainbow.p10k.zsh`

- [ ] **Step 1: Create the directory**
Run: `mkdir -p zsh/p10k_profiles`

- [ ] **Step 2: Generate/Copy initial profiles**
I will use the existing `.p10k.zsh` as the "classic" base and then modify it to create "lean" and "rainbow" variations.
Run: `cp zsh/.p10k.zsh zsh/p10k_profiles/classic.p10k.zsh`
Run: `cp zsh/.p10k.zsh zsh/p10k_profiles/lean.p10k.zsh`
Run: `cp zsh/.p10k.zsh zsh/p10k_profiles/rainbow.p10k.zsh`

- [ ] **Step 3: Commit initial files**
Run: `git add zsh/p10k_profiles && git commit -m "feat: create p10k profiles directory and base files"`

---

### Task 2: Implement the Cycle Function

**Files:**
- Modify: `zsh/.zshrc`

- [ ] **Step 1: Add the `cycle-p10k` function**
Add the following to the end of `zsh/.zshrc`:
```zsh
# P10k Style Cycler
cycle-p10k() {
  local profile_dir="$HOME/dotfiles/zsh/p10k_profiles"
  local config="$HOME/.p10k.zsh"
  local current_profile
  current_profile=$(readlink -f "$config")

  local profiles=(
    "$profile_dir/lean.p10k.zsh"
    "$profile_dir/classic.p10k.zsh"
    "$profile_dir/rainbow.p10k.zsh"
  )

  local next_index=0
  for i in {1..$#profiles}; do
    if [[ "${profiles[$i]}" == "$current_profile" ]]; then
      next_index=$(( (i % $#profiles) + 1 ))
      break
    fi
  done

  if [[ $next_index -eq 0 ]]; then next_index=1; fi

  local next_profile="${profiles[$next_index]}"
  local style_name="$(basename "$next_profile" .p10k.zsh)"

  ln -sf "$next_profile" "$config"
  source "$config"
  p10k reload # Ensure p10k fully picks up changes
  
  echo -e "\n%F{33}Prompt Style: %F{220}$style_name%f"
  zle && zle reset-prompt
}
zle -N cycle-p10k
bindkey '^Ps' cycle-p10k # Alt+s (or Ctrl+p, s)
```

- [ ] **Step 2: Convert existing `.p10k.zsh` to symlink**
Run: `ln -sf $HOME/dotfiles/zsh/p10k_profiles/classic.p10k.zsh $HOME/.p10k.zsh`

- [ ] **Step 3: Commit**
Run: `git add zsh/.zshrc && git commit -m "feat: implement cycle-p10k function and hotkey"`

---

### Task 3: Customize Styles for Visual Distinction

**Files:**
- Modify: `zsh/p10k_profiles/lean.p10k.zsh`
- Modify: `zsh/p10k_profiles/rainbow.p10k.zsh`

- [ ] **Step 1: Update Lean style (Minimal)**
Set `typeset -g POWERLEVEL9K_PROMPT_CHAR_BACKGROUND=none` and reduce segment spacing.
- [ ] **Step 2: Update Rainbow style (Colorful)**
Set `typeset -g POWERLEVEL9K_MODE=rainbow` and ensure background colors are distinct.
- [ ] **Step 3: Commit**
Run: `git add zsh/p10k_profiles && git commit -m "feat: customize lean and rainbow p10k styles"`

---

### Task 4: Final Verification

- [ ] **Step 1: Test cycling**
Source the new zshrc and press the hotkey to verify style changes.
- [ ] **Step 2: Verify Git status**
Ensure the Git status segment is visible and distinct in each mode.
