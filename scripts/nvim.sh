#!/bin/bash
echo "🛠️ Setting up Neovim..."

# Install Lazy.nvim (plugin manager)
LAZY_DIR="$HOME/.local/share/nvim/lazy/Lazy.nvim"
if [ ! -d "$LAZY_DIR" ]; then
  git clone https://github.com/folke/lazy.nvim.git --branch=stable "$LAZY_DIR"
fi

# Install Mason, LSP, DAP, etc. via headless mode
nvim --headless "+Lazy! sync" +qa

echo "✅ Neovim plugins installed."
