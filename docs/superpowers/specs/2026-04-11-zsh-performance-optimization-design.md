# Zsh Performance Optimization Design

**Date:** 2026-04-11
**Topic:** Zsh Startup Performance & Environment Management
**Status:** Approved

## 1. Goal
Reduce Zsh startup time from **0.93s** to **< 0.2s** while maintaining all existing functionality (aliases, themes, Python environment management).

## 2. Current State Analysis
- **Manager:** Antigen (Sequential/Blocking loader).
- **Bottlenecks:** 
    - Broken `VIRTUALENVWRAPPER_PYTHON` path causing Python errors and delay.
    - 13+ Oh-My-Zsh/Third-party bundles loading synchronously.
    - Redundant `compinit` calls and unoptimized completion caching.

## 3. Proposed Architecture

### 3.1 Plugin Management Swap
- **Replacement:** Antigen $\rightarrow$ **Zinit** (Turbo Mode).
- **Strategy:**
    - Load core shell features (P10k prompt) immediately.
    - Load interactive helpers (`zsh-syntax-highlighting`, `zsh-autosuggestions`) after the prompt appears (Turbo mode: wait 0s).
    - Load heavyweight tools (Docker, Pip, Heroku completions) after a delay (Turbo mode: wait 1-2s).

### 3.2 Python Environment Optimization
- **Fix:** Update `VIRTUALENVWRAPPER_PYTHON` to use `command -v python3` for robust path discovery.
- **Lazy Load:** Initialize `virtualenvwrapper` only upon calling `workon`, `mkvirtualenv`, or `lsvirtualenv`.

### 3.3 Completion & Prompt
- **Prompt:** Optimize `Powerlevel10k` Instant Prompt placement at the very top of `.zshrc`.
- **Completions:** Use a single, cached `compinit` call handled by Zinit's `zicompinit` to avoid duplicate overhead.

## 4. Implementation Details
- **Migration Plan:** 
    1. Backup existing `.zshrc`.
    2. Install Zinit.
    3. Port Antigen bundles to Zinit syntax.
    4. Implement lazy-loading wrappers for Python tools.
    5. Clean up redundant alias/env code.

## 5. Success Criteria
- Startup time **< 200ms**.
- Zero "ModuleNotFoundError" errors on startup.
- All existing aliases (`dps`, `ll`, `copy/paste`, `workon`) functional.

