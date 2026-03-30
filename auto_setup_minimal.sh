#!/usr/bin/env bash

set -euo pipefail

REPO_ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
TARGET_REPO="$HOME/dotfiles"
LOCAL_BIN="$HOME/.local/bin"
TMUX_CONFIG_DIR="$HOME/.config/tmux"
RANGER_TARGET="$HOME/.config/ranger"
FZF_ZSH_TARGET="$HOME/.fzf.zsh"

APT_PACKAGES=(
  atool
  bat
  build-essential
  caca-utils
  cmake
  curl
  fd-find
  ffmpegthumbnailer
  file
  fzf
  git
  highlight
  jq
  libimage-exiftool-perl
  mediainfo
  neovim
  ninja-build
  poppler-utils
  python3-pip
  python3-venv
  ranger
  ripgrep
  stow
  tmux
  tree
  unzip
  w3m
  wget
  xclip
  xdg-utils
  xsel
  zsh
)

have_sudo() {
  command -v sudo >/dev/null 2>&1
}

as_root() {
  if have_sudo; then
    sudo "$@"
  else
    "$@"
  fi
}

append_if_available() {
  local package="$1"
  if apt-cache show "$package" >/dev/null 2>&1; then
    APT_PACKAGES+=("$package")
  fi
}

ensure_repo_path() {
  if [ "$REPO_ROOT" != "$TARGET_REPO" ]; then
    ln -sfnT "$REPO_ROOT" "$TARGET_REPO"
  fi
}

install_apt_packages() {
  append_if_available fonts-powerline
  if apt-cache show openjdk-21-jre-headless >/dev/null 2>&1; then
    APT_PACKAGES+=(openjdk-21-jre-headless)
  else
    append_if_available openjdk-17-jre-headless
  fi

  as_root apt-get update
  as_root apt-get install -y --no-install-recommends "${APT_PACKAGES[@]}"
}

setup_local_bin() {
  mkdir -p "$LOCAL_BIN"

  if command -v batcat >/dev/null 2>&1 && ! command -v bat >/dev/null 2>&1; then
    ln -sfn "$(command -v batcat)" "$LOCAL_BIN/bat"
  fi

  if command -v fdfind >/dev/null 2>&1 && ! command -v fd >/dev/null 2>&1; then
    ln -sfn "$(command -v fdfind)" "$LOCAL_BIN/fd"
  fi
}

link_dotfiles() {
  mkdir -p "$HOME/.config"
  stow -d "$REPO_ROOT" -t "$HOME" zsh tmux nvim
  ln -sfnT "$REPO_ROOT/i3/.config/ranger" "$RANGER_TARGET"
}

install_tpm() {
  if [ ! -d "$HOME/.tmux/plugins/tpm/.git" ]; then
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
  fi

  if [ -x "$HOME/.tmux/plugins/tpm/bin/install_plugins" ]; then
    "$HOME/.tmux/plugins/tpm/bin/install_plugins" || true
  fi
}

install_nvm_and_node() {
  export NVM_DIR="$HOME/.nvm"

  if [ ! -s "$NVM_DIR/nvm.sh" ]; then
    curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
  fi

  # shellcheck disable=SC1090
  . "$NVM_DIR/nvm.sh"
  nvm install --lts
  nvm alias default 'lts/*'
}

install_python_helpers() {
  python3 -m pip install --user --break-system-packages --upgrade pip
  python3 -m pip install --user --break-system-packages virtualenvwrapper powerline-status ranger-tmux
}

setup_powerline_tmux_config() {
  local powerline_tmux_conf

  mkdir -p "$TMUX_CONFIG_DIR"
  powerline_tmux_conf=$(
    python3 -c 'import pathlib, powerline; print(pathlib.Path(powerline.__file__).resolve().parent / "bindings/tmux/powerline.conf")'
  )

  if [ -f "$powerline_tmux_conf" ]; then
    ln -sfn "$powerline_tmux_conf" "$TMUX_CONFIG_DIR/powerline.conf"
  fi
}

setup_fzf_shell_integration() {
  if [ ! -f "$FZF_ZSH_TARGET" ] && [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]; then
    cat >"$FZF_ZSH_TARGET" <<'EOF'
[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
EOF
  fi
}

bootstrap_neovim() {
  nvim --headless "+Lazy! sync" +qa || true
}

switch_default_shell() {
  local zsh_path
  zsh_path=$(command -v zsh)

  if [ "${SHELL:-}" != "$zsh_path" ]; then
    chsh -s "$zsh_path" "$USER" || true
  fi
}

main() {
  ensure_repo_path
  install_apt_packages
  setup_local_bin
  link_dotfiles
  install_tpm
  install_nvm_and_node
  install_python_helpers
  setup_powerline_tmux_config
  setup_fzf_shell_integration
  bootstrap_neovim
  switch_default_shell

  printf '%s\n' "Minimal dotfile bootstrap completed."
  printf '%s\n' "Open a new shell or run: exec zsh"
}

main "$@"
