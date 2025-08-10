#!/bin/bash
#
# Package installation

# ---
# Pacman packages (Arch Linux)
# ---
PACMAN_PACKAGES=(
  "base-devel"
  "git"
  "neovim"
  "tmux"
  "zsh"
  "wezterm"
  "lazygit"
  "yazi"
  "chezmoi"
)

# ---
# Main installation function
# ---
install_packages() {
  info "Installing packages..."

  # Detect package manager
  if command -v pacman &>/dev/null; then
    # Arch Linux
    sudo pacman -Syu --needed --noconfirm "${PACMAN_PACKAGES[@]}"
  elif command -v apt-get &>/dev/null; then
    # Debian/Ubuntu
    # Add package installation for apt-get here
    # Example: sudo apt-get install -y <package1> <package2>
    info "Debian/Ubuntu support is not fully implemented yet."
    info "Please edit scripts/packages.sh and add the corresponding package names."
  elif command -v dnf &>/dev/null; then
    # Fedora
    # Add package installation for dnf here
    # Example: sudo dnf install -y <package1> <package2>
    info "Fedora support is not fully implemented yet."
    info "Please edit scripts/packages.sh and add the corresponding package names."
  else
    error "No supported package manager found."
  fi

  success "Packages installed."
}
