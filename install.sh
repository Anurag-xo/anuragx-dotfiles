#!/bin/bash
# FILE: install.sh
set -euo pipefail

echo "🚀 Bootstrapping your system..."

DOTFILES_DIR="$HOME/.dotfiles"
REPO_URL="https://github.com/anuragx/dotfiles.git"  # Update with your actual URL

# Clone dotfiles
if [ ! -d "$DOTFILES_DIR" ]; then
  git clone "$REPO_URL" "$DOTFILES_DIR"
else
  git -C "$DOTFILES_DIR" pull
fi

# Run setup scripts
"$DOTFILES_DIR/scripts/packages.sh"
"$DOTFILES_DIR/scripts/link.sh"
"$DOTFILES_DIR/scripts/shell.sh"
"$DOTFILES_DIR/scripts/nvim.sh"
"$DOTFILES_DIR/scripts/yazi.sh"

echo "✅ Dotfiles installed! Restart your shell with: exec \$SHELL"
