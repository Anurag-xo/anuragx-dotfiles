#!/bin/bash
set -euo pipefail

install_macos() {
  if ! command -v brew &> /dev/null; then
    echo "📥 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  brew install neovim tmux lazygit yazi wezterm zsh git node ripgrep
}

install_ubuntu() {
  sudo apt update
  sudo apt install -y curl git
  curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
  echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
  sudo apt update
  sudo apt install -y neovim tmux zsh nodejs npm wezterm cargo ripgrep build-essential
  cargo install --locked yazi
}

install_arch() {
  sudo pacman -Syu --noconfirm neovim tmux lazygit yazi wezterm zsh git nodejs npm ripgrep
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
