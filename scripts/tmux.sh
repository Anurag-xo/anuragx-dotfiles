#!/bin/bash
set -euo pipefail

TPM_DIR="$HOME/.tmux/plugins/tpm"

if [ ! -d "$TPM_DIR" ]; then
  echo "📥 Installing TPM (Tmux Plugin Manager)..."
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
else
  echo "✅ TPM already installed"
fi

echo "💡 Run 'Prefix + I' in Tmux to install plugins"
