# FILE: install.sh
#!/bin/bash

set -euo pipefail

echo "🚀 Bootstrapping your system..."

# Ensure git is installed
if ! command -v git &> /dev/null; then
  echo "📦 Installing git..."
  sudo apt-get update && sudo apt-get install -y git
fi

# Clone or update dotfiles (if not already in the repo)
DOTFILES_DIR="$HOME/.dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
  echo "📂 Cloning dotfiles..."
  git clone https://github.com/anuragx-dotfiles/dotfiles.git "$DOTFILES_DIR"
else
  echo "🔄 Updating dotfiles..."
  git -C "$DOTFILES_DIR" pull
fi

# Link configs
echo "🔗 Creating symlinks..."
"$DOTFILES_DIR/scripts/link.sh"

# Install dependencies
echo "🛠 Installing system packages..."
"$DOTFILES_DIR/scripts/packages.sh"

# Setup Neovim, Yazi, etc.
echo "⚙️ Setting up apps..."
"$DOTFILES_DIR/scripts/setup.sh"

echo "✅ Done! Restart your shell or run: exec \$SHELL"
