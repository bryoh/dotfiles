# P10k Visual Style Cycler Design

**Date:** 2026-04-11
**Topic:** Zsh Prompt Styling & Git Visualization
**Status:** Approved

## 1. Goal
Implement a mechanism to cycle through multiple Powerlevel10k visual styles (e.g., Lean, Classic, Rainbow) instantly within the same shell session, specifically to visualize Git status differently based on need.

## 2. Current State Analysis
- **Theme:** Powerlevel10k (P10k).
- **Config:** Single `~/.p10k.zsh` file.
- **Limitation:** Switching styles requires manually running `p10k configure` or editing the config file and restarting the shell.

## 3. Proposed Architecture

### 3.1 Profile Management
- **Directory:** `zsh/p10k_profiles/` (inside the dotfiles repo).
- **Profiles:**
    - `lean.p10k.zsh`: Minimalist, text-only.
    - `classic.p10k.zsh`: Balanced, uses brackets/icons.
    - `rainbow.p10k.zsh`: High-contrast, color-blocked segments.
- **Symlink:** `~/.p10k.zsh` will point to the active profile in the dotfiles directory.

### 3.2 Cycling Logic
- **Function:** `cycle-p10k`
    - Locates the current active profile via `readlink`.
    - Identifies the next profile in the alphabetical list.
    - Updates the symlink to the next profile.
    - Sources the new profile instantly using `source ~/.p10k.zsh`.
- **Hotkey:** Bind `Alt+s` (or similar) to trigger the `cycle-p10k` function.

### 3.3 Visual Feedback
- Upon cycling, the shell will print a temporary status message: `Style: [Rainbow]`.
- Ensure Git status segments are enabled and prominent in all profiles.

## 4. Implementation Details
- **Profile Generation:** Use `p10k configure` to generate the base files, then tune them for Git prominence.
- **Persistence:** The symlink ensures the last selected style persists across new terminal windows.
- **Performance:** Re-sourcing P10k is extremely fast (< 50ms) and does not require a full shell restart.

## 5. Success Criteria
- Instant style switching using a single command or hotkey.
- At least 3 distinct visual styles available.
- No shell errors or "broken" prompt states during transitions.

