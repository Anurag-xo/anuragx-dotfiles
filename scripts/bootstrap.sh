#!/bin/bash
set -euo pipefail

# Install git if missing
if ! command -v git &> /dev/null; then
  echo "📦 Installing git..."
  sudo apt update && sudo apt install -y git || brew install git
fi

echo "📥 Cloning dotfiles..."
git clone https://github.com/anuragx/dotfiles ~/.dotfiles
~/.dotfiles/install.sh

echo "✅ Setup complete! Run 'exec zsh' to reload shell."
