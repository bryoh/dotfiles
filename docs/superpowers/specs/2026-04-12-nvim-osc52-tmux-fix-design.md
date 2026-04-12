# Neovim OSC 52 Tmux Compatibility Fix

**Date:** 2026-04-12
**Topic:** Neovim OSC 52 in Tmux over SSH
**Status:** Approved

## 1. Goal
Fix the Neovim OSC 52 clipboard sync so that it works while running inside a Tmux session over SSH.

## 2. Current State Analysis
- **Problem:** Neovim's built-in OSC 52 provider sends standard sequences, but Tmux blocks them from reaching the terminal emulator unless wrapped in a DCS (Device Control String) sequence.
- **Tmux:** Confirmed active (`TMUX` env var set).

## 3. Proposed Architecture

### 3.1 Mechanism: Tmux Passthrough
- To pass OSC 52 through Tmux, the sequence must be wrapped in: `\ePtmux;\e[original_sequence]\e\ `.
- We'll use a specialized plugin (`ojroques/nvim-osc52`) or a custom provider that handles the Tmux wrapping automatically.

### 3.2 Implementation: Neovim Configuration
- **File:** `nvim/.config/nvim/lua/config/options.lua`
- **Action:** Replace the built-in provider logic with a more robust implementation that handles Tmux passthrough.

## 4. Implementation Details
- **Improved Provider Logic:**
    ```lua
    local function osc52_copy(register)
      return function(lines)
        local s = table.concat(lines, "\n")
        local b64 = vim.fn.system("base64 | tr -d '\n'", s)
        if vim.env.TMUX then
          b64 = "\x1bPtmux;\x1b]52;c;" .. b64 .. "\x07\x1b\"
        else
          b64 = "\x1b]52;c;" .. b64 .. "\x07"
        fi
        io.stdout:write(b64)
      end
    end
    ```

## 5. Success Criteria
- Yanking text in Neovim inside Tmux over SSH updates the local machine's clipboard.
- No impact on local (non-SSH/non-Tmux) performance.

