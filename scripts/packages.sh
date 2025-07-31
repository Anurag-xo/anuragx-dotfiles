#!/bin/bash
echo "📦 Installing system packages..."

if command -v apt &> /dev/null; then
  sudo apt update
  sudo apt install -y \
    zsh git curl wget build-essential \
    neovim ripgrep fd-find fzf \
    tmux nodejs npm yarn \
    wezterm lazygit
elif command -v pacman &> /dev/null; then
  sudo pacman -Syu --noconfirm \
    zsh git curl wget base-devel \
    neovim ripgrep fd fzf \
    tmux nodejs npm yarn \
    wezterm lazygit
elif command -v brew &> /dev/null; then
  brew install zsh git ripgrep fd fzf tmux wezterm lazygit node yarn
fi

# Install Yazi (Rust-based) - via cargo
if ! command -v yazi &> /dev/null; then
  echo "🔧 Installing Yazi..."
  curl -fsSL https://get.yazi.rs | bash
fi

echo "✅ Packages installed."
