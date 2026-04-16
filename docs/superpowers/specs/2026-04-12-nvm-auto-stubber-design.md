# Automatic NVM Stubber Design

**Date:** 2026-04-12
**Topic:** Scalable NVM Lazy-Loading
**Status:** Approved

## 1. Goal
Implement a dynamic lazy-loading mechanism for NVM and all global Node packages to ensure fast shell startup while automatically supporting any newly installed binaries without manual configuration changes.

## 2. Current State Analysis
- **Current Setup:** Manual stubs for `nvm`, `node`, `npm`, `yarn`, and `gemini`.
- **Problem:** Brittle and requires manual updates every time a new global package (e.g., `code`, `eslint`) is installed.

## 3. Proposed Architecture

### 3.1 Dynamic Stub Generation
- **Logic:**
    1. Identify the default Node version path via `~/.nvm/alias/default`.
    2. Loop through all files in the `bin` directory of that version.
    3. Generate a Zsh function for each file that triggers NVM initialization.
- **Example:**
    ```zsh
    for cmd in $(ls "$NVM_BIN_PATH"); do
      eval "$cmd() { unfunction $(ls \"$NVM_BIN_PATH\"); zsh-defer-nvm; $cmd \"\$@\" }"
    done
    ```

### 3.2 Performance
- **Overhead:** Scanning the directory and creating functions takes ~5-15ms.
- **Comparison:** Fully loading NVM takes ~300-600ms.

## 4. Implementation Details
- **File:** `zsh/.zshrc`
- **Refactoring:** Replace the hardcoded `nvm()`, `node()`, etc., functions with the dynamic loop.
- **Fallbacks:** Ensure the `nvm` command itself is always included in the stub list.

## 5. Success Criteria
- Shell startup remains below 0.45s.
- `which code`, `which gemini`, and `which node` all return valid paths after the first call.
- No manual updates required after `npm install -g <package>`.

