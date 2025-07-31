#!/bin/bash
set -euo pipefail

echo "🚀 Setting up dotfiles..."

# Allow override
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
REPO_URL="${DOTFILES_REPO:-https://github.com/anuragx/dotfiles.git}"

# Clone or update
if [ ! -d "$DOTFILES_DIR" ]; then
  git clone "$REPO_URL" "$DOTFILES_DIR"
else
  echo "✅ Dotfiles already cloned"
  git -C "$DOTFILES_DIR" pull --ff-only
fi

# Enter dotfiles dir
cd "$DOTFILES_DIR"

# Run setup scripts
./scripts/packages.sh
./scripts/links.sh
./scripts/nvim.sh
./scripts/tmux.sh
./scripts/yazi.sh  # ✅ Added missing call

echo "✅ Dotfiles setup complete!"
echo "💡 Run 'exec zsh' to reload shell"
