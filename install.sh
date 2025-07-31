#!/bin/bash
set -euo pipefail

echo "🚀 Setting up dotfiles..."

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
REPO_URL="${DOTFILES_REPO:-https://github.com/Anurag-xo/dotfiles.git}"

if [ ! -d "$DOTFILES_DIR" ]; then
  git clone "$REPO_URL" "$DOTFILES_DIR"
else
  git -C "$DOTFILES_DIR" pull --ff-only
fi

cd "$DOTFILES_DIR"

./scripts/packages.sh
./scripts/links.sh
./scripts/nvim.sh
./scripts/tmux.sh
./scripts/yazi.sh

echo "✅ Dotfiles setup complete!"
echo "💡 Run 'exec zsh' to reload shell"
