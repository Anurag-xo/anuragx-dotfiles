#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Helper Functions ---
info() {
    echo "INFO: $1"
}

warn() {
    echo "WARN: $1"
}

error() {
    echo "ERROR: $1"
    exit 1
}

# --- Package Installation ---

# List of packages to install, separated by spaces
# Add packages here
PACKAGES_APT="zsh tmux neovim lazygit git curl wget"
PACKAGES_DNF="zsh tmux neovim lazygit git curl wget"
PACKAGES_PACMAN="zsh tmux neovim lazygit git curl wget yazi"

install_packages() {
    local pkg_manager

    if command -v apt-get &>/dev/null; then
        pkg_manager="apt"
    elif command -v dnf &>/dev/null; then
        pkg_manager="dnf"
    elif command -v pacman &>/dev/null; then
        pkg_manager="pacman"
    else
        error "Unsupported package manager. Please install packages manually."
    fi

    info "Using $pkg_manager to install packages."

    local packages_to_install
    case $pkg_manager in
        apt) packages_to_install=$PACKAGES_APT ;;
        dnf) packages_to_install=$PACKAGES_DNF ;;
        pacman) packages_to_install=$PACKAGES_PACMAN ;;
    esac

    info "Updating package lists..."
    case $pkg_manager in
        apt) sudo apt-get update ;;
        dnf) sudo dnf check-update || true ;;
        pacman) sudo pacman -Syu --noconfirm ;;
    esac

    info "Installing packages: $packages_to_install"
    case $pkg_manager in
        apt) sudo apt-get install -y $packages_to_install ;;
        dnf) sudo dnf install -y $packages_to_install ;;
        pacman) sudo pacman -S --noconfirm --needed $packages_to_install ;;
    esac
}

# --- Application-specific Installations ---

install_oh_my_zsh() {
    if [ -d "$HOME/.oh-my-zsh" ]; then
        info "Oh My Zsh is already installed."
    else
        info "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi
}

install_powerlevel10k() {
    if [ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
        info "Powerlevel10k is already installed."
    else
        info "Installing Powerlevel10k..."
        if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes" ]; then
            mkdir -p "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes"
        fi
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
            "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
    fi
}

install_wezterm() {
    if command -v wezterm &>/dev/null; then
        info "Wezterm is already installed."
        return
    fi

    info "Installing Wezterm..."
    local os
    os=$(uname -s)
    if [ "$os" = "Linux" ]; then
        if command -v apt-get &>/dev/null; then
            local DOWNLOAD_URL
            DOWNLOAD_URL=$(curl -s "https://api.github.com/repos/wez/wezterm/releases/latest" | grep -o 'https://.*wezterm-.*\.deb' | head -n 1)
            if [ -z "$DOWNLOAD_URL" ]; then
                warn "Could not find Wezterm .deb package. Please install it manually."
                return
            fi
            local DEB_FILE
            DEB_FILE=$(basename "$DOWNLOAD_URL")
            curl -L -o "/tmp/$DEB_FILE" "$DOWNLOAD_URL"
            sudo apt install -y "/tmp/$DEB_FILE"
            rm "/tmp/$DEB_FILE"
        elif command -v dnf &>/dev/null; then
             sudo dnf copr enable wez/wezterm -y
             sudo dnf install wezterm -y
        else
            warn "Wezterm binary download is not configured for this package manager. Please install it manually."
        fi
    else
        warn "Wezterm installation is not configured for this OS ($os). Please install it manually."
    fi
}

# --- Change Default Shell ---
change_shell() {
    # Check if zsh is already the default shell
    if [ "$(basename "$SHELL")" = "zsh" ]; then
        info "Default shell is already zsh."
        return
    fi

    # Check if zsh is installed
    if ! command -v zsh &> /dev/null; then
        warn "zsh is not installed. Cannot change default shell."
        return
    fi

    info "Changing default shell to zsh..."
    if command -v chsh &>/dev/null; then
        # The user will be prompted for their password here.
        # Some systems might require running chsh with sudo.
        # This command assumes the user running it has the necessary permissions.
        chsh -s "$(command -v zsh)"
        info "Default shell changed to zsh. Please log out and log back in for the change to take effect."
    else
        warn "Could not find chsh. Please change your default shell manually."
    fi
}


# --- Main Execution ---

main() {
    install_packages
    install_oh_my_zsh
    install_powerlevel10k
    install_wezterm
    change_shell
    info "Installation script finished."
    info "Please restart your shell or source your .zshrc to apply changes."
}

main
