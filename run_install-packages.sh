#!/bin/bash

# Function to install packages on Arch Linux
install_arch() {
    sudo pacman -Syu --noconfirm
    sudo pacman -S --noconfirm \
        zsh \
        tmux \
        wezterm \
        neovim \
        yazi \
        stow \
        ripgrep \
        fd \
        unzip \
        git \
        go \
        npm \
        python \
        jdk-openjdk \
        ttf-nerd-fonts-symbols
    
    # Install lazygit
    go install github.com/jesseduffield/lazygit@latest
}

# Function to install packages on Debian/Ubuntu
install_debian() {
    sudo apt-get update
    sudo apt-get install -y \
        zsh \
        tmux \
        stow \
        ripgrep \
        fd-find \
        unzip \
        git \
        golang \
        npm \
        python3 \
        default-jdk

    # Install lazygit
    go install github.com/jesseduffield/lazygit@latest

    # Install WezTerm
    curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
    echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
    sudo apt-get update
    sudo apt-get install -y wezterm

    # Install Neovim
    sudo add-apt-repository ppa:neovim-ppa/stable
    sudo apt-get update
    sudo apt-get install -y neovim

    # Install Yazi
    cargo install --locked yazi-fm

    # Install Nerd Fonts
    mkdir -p ~/.local/share/fonts
    cd ~/.local/share/fonts
    curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/NerdFontsSymbolsOnly.zip
    unzip NerdFontsSymbolsOnly.zip
    rm NerdFontsSymbolsOnly.zip
    fc-cache -f -v
}

# Function to install packages on macOS
install_macos() {
    brew install \
        zsh \
        tmux \
        wezterm \
        neovim \
        yazi \
        stow \
        ripgrep \
        fd \
        unzip \
        git \
        go \
        npm \
        python \
        openjdk

    # Install lazygit
    go install github.com/jesseduffield/lazygit@latest

    # Install Nerd Fonts
    brew tap homebrew/cask-fonts
    brew install --cask font-nerd-font-symbols-only
}

# Detect the operating system
if [[ "$(uname)" == "Linux" ]]; then
    if [[ -f /etc/arch-release ]]; then
        install_arch
    elif [[ -f /etc/debian_version ]]; then
        install_debian
    fi
elif [[ "$(uname)" == "Darwin" ]]; then
    install_macos
fi
