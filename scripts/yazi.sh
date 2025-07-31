#!/bin/bash
set -euo pipefail

echo "🖼️ Setting up Yazi..."

# Apply flavor (if defined in package.toml)
if command -v yazi &> /dev/null; then
  yazi install
  echo "🎨 Yazi flavor applied"
else
  echo "⚠️ Yazi not installed. Install with: cargo install --locked yazi"
fi

# Optional: install global tools
npm install -g @yazi-cli/core 2>/dev/null || true

echo "✅ Yazi ready."
