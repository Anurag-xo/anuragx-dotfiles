#!/bin/bash
set -euo pipefail

echo "🚀 Setting up dotfiles..."

# Allow override
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
REPO_URL="${DOTFILES_REPO:-https://github.com/anuragx/dotfiles.git}"

# Clone if not exists
if [ ! -d "$DOTFILES_DIR" ]; then
  git clone "$REPO_URL" "$DOTFILES_DIR"
else
  echo "✅ Dotfiles already cloned"
fi

# Source all scripts
cd "$DOTFILES_DIR"

# Install packages
./scripts/packages.sh

# Create symlinks
./scripts/links.sh

# Setup Neovim
./scripts/nvim.sh

# Setup Tmux
./scripts/tmux.sh

echo "✅ Dotfiles setup complete!"
echo "💡 Run 'exec zsh' to reload shell"
