#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

# Get the directory where the script is located (your dotfiles repo)
export DOTFILES_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Source the helper scripts
source "$DOTFILES_DIR/scripts/helpers.sh" # We'll create this for common functions
source "$DOTFILES_DIR/scripts/packages.sh"
source "$DOTFILES_DIR/scripts/links.sh"

main() {
    # Ensure git and curl are installed (basic requirements mentioned in README)
    echo "Checking for essential tools (git, curl)..."
    ensure_basic_tools

    # Detect OS and install packages
    echo "Installing packages..."
    install_packages

    # Create symlinks
    echo "Setting up symlinks..."
    create_links

    # Post-installation steps (e.g., for zsh plugins, nvim plugins)
    echo "Running post-installation setup..."
    post_install

    echo "Dotfiles installation complete!"
    echo "You might need to restart your terminal or run 'source ~/.zshrc' to see all changes."
    echo "For Zsh plugins (zinit) and Neovim plugins to fully initialize, open a new terminal session, then run 'zsh' and 'nvim' respectively."
}

main "$@"
