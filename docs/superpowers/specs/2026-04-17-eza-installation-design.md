# Eza Installation and Integration Design

## Purpose
Install the modern replacement for `ls`, `eza`, and integrate it into the user's workflow via aliases in `zsh` and `bash`.

## Scope
-   **Package:** `eza`
-   **Method:** Ubuntu Universe Repository (`apt`)
-   **Configuration:** `.zshrc` and `.bashrc`

## Architecture
-   **Installation:** `sudo apt install -y eza`
-   **Configuration:**
    -   `alias ls='eza --icons'`
    -   `alias ll='eza -lh --icons --git'`
    -   `alias la='eza -a --icons'`

## Success Criteria
-   `eza --version` returns a valid version (0.18.2-1 on Noble).
-   `ls` and `ll` aliases work in a new shell session.
-   Visual confirmation: `eza` displays icons and colorized output.

## Risks & Mitigations
-   **Dependency:** `eza` requires a Nerd Font for icons. User has `.fonts` directory, but terminal emulator support depends on the terminal. Mitigation: Use `--icons` and explain if it looks weird.
-   **Environment:** User is on ARM64. Mitigation: Ubuntu 24.04 (Noble) has `eza` in the standard repositories for this architecture.
