#!/usr/bin/env bash

# --- Package Installation ---

# Define packages needed for different OSes
# Add or remove packages based on your actual requirements

# Common packages across Linux distros
COMMON_LINUX_PACKAGES=(
    "git"
    "curl"
    "wget"
    "zsh"
    "neovim"
    "tmux"
    "ripgrep"       # Required by many nvim plugins (Telescope)
    "fd-find"       # or 'fd' on some systems, required by many nvim plugins
    "fzf"           # Required by zsh fzf-tab, nvim plugins
    "bat"           # A cat(1) clone with wings
    "eza"           # A modern replacement for ls
    "tree"
    "htop"
    "jq"            # Command-line JSON processor
    "unzip"
    # Add other common tools you use
)

# macOS specific packages (to be installed via Homebrew)
MACOS_PACKAGES=(
    "git"
    "curl"
    "wget"
    "zsh"
    "neovim"
    "tmux"
    "ripgrep"
    "fd"            # Note: 'fd' on macOS via brew
    "fzf"
    "bat"
    "eza"
    "tree"
    "htop"
    "jq"
    "unzip"
    # "font-hack-nerd-font" # Optional: Install a Nerd Font via brew if desired
    # Add other macOS specific tools
)

# Function to get the list of packages based on the detected OS
get_package_list() {
    # Ensure OS is detected (should be set by helpers.sh)
    if [[ -z "$OS" ]]; then
        error "OS not detected. Call detect_os first."
    fi

    local package_list_var=""
    case "$OS" in
        "macOS")
            package_list_var="MACOS_PACKAGES"
            ;;
        "Debian/Ubuntu"|"Arch Linux"|"Fedora/RHEL")
            package_list_var="COMMON_LINUX_PACKAGES"
            ;;
        *)
            warn "No specific package list for OS '$OS'. Using common Linux list."
            package_list_var="COMMON_LINUX_PACKAGES"
            ;;
    esac

    # Print the package list, joining array elements with space
    # shellcheck disable=SC2154 # Variable is intended to be dynamic
    local packages
    IFS=" " read -r -a packages <<< "${!package_list_var}"
    echo "${packages[*]}"
}
