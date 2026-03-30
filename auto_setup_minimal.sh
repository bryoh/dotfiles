#!/usr/bin/env bash

set -euo pipefail

REPO_ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
TARGET_REPO="$HOME/dotfiles"
LOCAL_BIN="$HOME/.local/bin"
LOCAL_OPT="$HOME/.local/opt"
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

version_ge() {
  [ "$(printf '%s\n' "$2" "$1" | sort -V | head -n1)" = "$2" ]
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
  mkdir -p "$LOCAL_OPT"

  if command -v batcat >/dev/null 2>&1 && ! command -v bat >/dev/null 2>&1; then
    ln -sfn "$(command -v batcat)" "$LOCAL_BIN/bat"
  fi

  if command -v fdfind >/dev/null 2>&1 && ! command -v fd >/dev/null 2>&1; then
    ln -sfn "$(command -v fdfind)" "$LOCAL_BIN/fd"
  fi
}

install_neovim() {
  local current_version=""
  local archive_name=""
  local extract_dir=""
  local download_url=""
  local nvim_link_target=""
  local local_nvim=""

  export PATH="$LOCAL_BIN:$PATH"
  local_nvim="${LOCAL_BIN}/nvim"

  if [ -x "$local_nvim" ]; then
    nvim_link_target=$(readlink -f "$local_nvim" 2>/dev/null || true)
  fi

  if command -v nvim >/dev/null 2>&1; then
    current_version=$(nvim --version 2>/dev/null | awk 'NR==1 {sub(/^v/, "", $2); print $2}')
  fi

  if [ -n "$current_version" ] && version_ge "$current_version" "0.11.2"; then
    return
  fi

  case "$(uname -m)" in
    x86_64)
      archive_name="nvim-linux-x86_64.tar.gz"
      extract_dir="nvim-linux-x86_64"
      ;;
    aarch64|arm64)
      archive_name="nvim-linux-arm64.tar.gz"
      extract_dir="nvim-linux-arm64"
      ;;
    *)
      printf '%s\n' "Unsupported architecture for Neovim bootstrap: $(uname -m)" >&2
      exit 1
      ;;
  esac

  download_url="https://github.com/neovim/neovim/releases/latest/download/${archive_name}"

  if [ -n "$nvim_link_target" ] && [ "$nvim_link_target" != "${LOCAL_OPT}/${extract_dir}/bin/nvim" ]; then
    rm -f "$local_nvim"
  fi

  rm -rf "${LOCAL_OPT:?}/${extract_dir}"
  curl -fL "$download_url" -o "/tmp/${archive_name}"
  tar -C "$LOCAL_OPT" -xzf "/tmp/${archive_name}"
  rm -f "/tmp/${archive_name}"
  ln -sfn "${LOCAL_OPT}/${extract_dir}/bin/nvim" "$local_nvim"
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

install_node_helpers() {
  export NVM_DIR="$HOME/.nvm"
  # shellcheck disable=SC1090
  . "$NVM_DIR/nvm.sh"
  npm install -g tree-sitter-cli
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
  export PATH="$LOCAL_BIN:$PATH"
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
  install_neovim
  link_dotfiles
  install_tpm
  install_nvm_and_node
  install_node_helpers
  install_python_helpers
  setup_powerline_tmux_config
  setup_fzf_shell_integration
  bootstrap_neovim
  switch_default_shell

  printf '%s\n' "Minimal dotfile bootstrap completed."
  printf '%s\n' "Open a new shell or run: exec zsh"
}

main "$@"
