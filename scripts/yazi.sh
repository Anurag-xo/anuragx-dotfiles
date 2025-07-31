#!/bin/bash
echo "🖼️ Setting up Yazi..."

# Install Yazi flavors (if any)
# Example: yazi setup flavor
# Or just ensure config is in place (already symlinked)

# Optional: install global tools used by Yazi
npm install -g @yazi-cli/core 2>/dev/null || true

echo "✅ Yazi ready."
