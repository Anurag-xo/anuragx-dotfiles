#!/bin/bash
set -euo pipefail

echo "🚀 Setting up dotfiles from local directory..."

# Add cargo to PATH for this script's execution
export PATH="$HOME/.cargo/bin:$PATH"

# Get the directory of the install script
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd "$DOTFILES_DIR"

./scripts/packages.sh
./scripts/links.sh
./scripts/nvim.sh
./scripts/tmux.sh
./scripts/yazi.sh

echo "✅ Dotfiles setup complete!"
echo "💡 Run 'exec zsh' to reload shell"
