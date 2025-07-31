#!/bin/bash
set -euo pipefail

install_macos() {
  if ! command -v brew &> /dev/null; then
    echo "📥 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  brew install neovim tmux lazygit yazi wezterm zsh git
}

install_ubuntu() {
  sudo apt update
  sudo apt install -y neovim tmux lazygit zsh git curl
}

install_arch() {
  sudo pacman -Syu --noconfirm neovim tmux lazygit yazi wezterm zsh git
}

# Detect OS
case "$OSTYPE" in
  darwin*)  install_macos ;;
  linux*)
    if [ -f /etc/os-release ]; then
      . /etc/os-release
      case "$ID" in
        ubuntu|debian) install_ubuntu ;;
        arch|manjaro)  install_arch ;;
        *) echo "Unsupported Linux distro" && exit 1 ;;
      esac
    else
      echo "Could not detect Linux distro"
      exit 1
    fi
    ;;
  *) echo "Unsupported OS" && exit 1 ;;
esac
