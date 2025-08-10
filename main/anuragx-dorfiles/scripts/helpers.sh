#!/usr/bin/env bash

# --- Helper Functions ---

# Function to print messages
msg() {
    printf '\e[1;32m==>\e[0m %s\n' "$1"
}

# Function to print warnings
warn() {
    printf '\e[1;33mWarning:\e[0m %s\n' "$1"
}

# Function to print errors and exit
error() {
    printf '\e[1;31mError:\e[0m %s\n' "$1" >&2
    exit 1
}

# Function to create a symlink
# $1: Source file/directory (in dotfiles)
# $2: Destination file/directory (in home)
link() {
    local source="$1"
    local dest="$2"
    local dest_dir

    # Check if source exists
    if [[ ! -e "$source" ]]; then
        warn "Source '$source' does not exist. Skipping."
        return
    fi

    # Get the directory of the destination
    dest_dir="$(dirname "$dest")"

    # Create destination directory if it doesn't exist
    if [[ ! -d "$dest_dir" ]]; then
        msg "Creating directory '$dest_dir'"
        mkdir -p "$dest_dir"
    fi

    # Check if destination already exists
    if [[ -e "$dest" || -L "$dest" ]]; then
        # If it's already a correct symlink, skip
        if [[ -L "$dest" && "$(readlink "$dest")" == "$source" ]]; then
            msg "Link already exists: $dest -> $source"
            return
        else
            # If it's a file/dir or a broken/incorrect symlink, back it up
            msg "Backing up '$dest' to '$dest.backup'"
            mv "$dest" "$dest.backup"
        fi
    fi

    # Create the symlink
    msg "Linking '$dest' -> '$source'"
    ln -s "$source" "$dest"
}

# Function to detect OS and set package manager variables
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        export OS="macOS"
        export PKG_MANAGER="brew"
    elif command -v apt-get &> /dev/null; then
        export OS="Debian/Ubuntu"
        export PKG_MANAGER="apt"
    elif command -v pacman &> /dev/null; then
        export OS="Arch Linux"
        export PKG_MANAGER="pacman"
    elif command -v dnf &> /dev/null; then
        export OS="Fedora/RHEL"
        export PKG_MANAGER="dnf"
    else
        error "Unsupported operating system or package manager not found."
    fi
    msg "Detected OS: $OS (Package Manager: $PKG_MANAGER)"
}

# Function to ensure git and curl are installed
ensure_basic_tools() {
    detect_os # Sets PKG_MANAGER

    local missing_tools=()
    if ! command -v git &> /dev/null; then missing_tools+=("git"); fi
    if ! command -v curl &> /dev/null; then missing_tools+=("curl"); fi

    if [[ ${#missing_tools[@]} -gt 0 ]]; then
        msg "Installing missing basic tools: ${missing_tools[*]}"
        case "$PKG_MANAGER" in
            apt)
                sudo apt update
                sudo apt install -y "${missing_tools[@]}"
                ;;
            pacman)
                sudo pacman -Sy --noconfirm "${missing_tools[@]}"
                ;;
            dnf)
                sudo dnf install -y "${missing_tools[@]}"
                ;;
            brew)
                brew install "${missing_tools[@]}"
                ;;
            *)
                error "Cannot install basic tools: Unknown package manager '$PKG_MANAGER'. Please install git and curl manually."
                ;;
        esac
    fi
}

# Function to install packages based on detected OS
install_packages() {
    # Ensure OS is detected
    if [[ -z "$PKG_MANAGER" ]]; then
        detect_os
    fi

    # Get the list of packages for the current OS
    local packages_to_install
    packages_to_install=$(get_package_list)

    if [[ -z "$packages_to_install" ]]; then
        warn "No packages defined for OS '$OS' or package list is empty."
        return
    fi

    msg "Installing packages for $OS..."
    case "$PKG_MANAGER" in
        apt)
            sudo apt update
            sudo apt install -y $packages_to_install
            ;;
        pacman)
            # shellcheck disable=SC2086 # Intended word splitting
            sudo pacman -Syu --noconfirm $packages_to_install
            ;;
        dnf)
            sudo dnf install -y $packages_to_install
            ;;
        brew)
             # shellcheck disable=SC2086 # Intended word splitting
            brew install $packages_to_install
            ;;
        *)
            error "Installation logic for package manager '$PKG_MANAGER' is not implemented."
            ;;
    esac
}

# Function to run post-installation steps
post_install() {
    # Ensure Zsh is installed before trying to change shell or run zsh commands
    if ! command -v zsh &> /dev/null; then
        error "Zsh is not installed. It should have been installed by packages.sh."
    fi

    # 1. Change default shell to zsh (optional, requires user password)
    local current_shell
    current_shell=$(getent passwd "$USER" | cut -d: -f7)
    if [[ "$current_shell" != *"zsh" ]]; then
        msg "Your default shell is '$current_shell'. Would you like to change it to Zsh? (y/N)"
        read -r response
        if [[ "$response" =~ ^[Yy]$ ]]; then
            chsh -s "$(which zsh)" || warn "Failed to change shell. You might need to do it manually."
        else
             msg "Skipping shell change. Remember to run 'zsh' manually or change your default shell later."
        fi
    fi

    # 2. Initialize Zinit (if not already present)
    # The .zshrc should handle cloning zinit if needed on first run.
    # We can trigger a quick zsh run to potentially start the process.
    # However, full plugin installation usually requires an interactive session.
    # Let's just inform the user.
    if [[ -f "$HOME/.zshrc" ]]; then
         msg "Zsh configuration linked. Zinit plugins will be installed on first Zsh run."
         msg "Open a new terminal (which should start Zsh) to initialize plugins."
    fi

    # 3. Initialize Neovim plugins
    if command -v nvim &> /dev/null; then
        msg "Installing Neovim plugins..."
        # Run Neovim headlessly to install plugins via Lazy.nvim
        # Adjust the command if your plugin manager uses a different sync command
        nvim --headless "+Lazy! sync" +qa || warn "Failed to install Neovim plugins automatically. Run 'nvim' and check."
    else
        warn "Neovim not found. Skipping Neovim plugin installation."
    fi

    # 4. Remind about fonts (Powerlevel10k)
    msg "Please ensure a Nerd Font is installed and configured in your terminal for Powerlevel10k/icons to display correctly."

    # 5. Remind about Tmux Plugin Manager (TPM)
    # TPM usually installs plugins on the first `prefix + I` inside tmux.
    # We can clone TPM if it's not there, but installing plugins needs tmux session.
    local tpm_dir="$HOME/.tmux/plugins/tpm"
    if [[ -f "$HOME/.tmux.conf" ]]; then
        if [[ ! -d "$tpm_dir" ]]; then
            msg "Installing Tmux Plugin Manager (TPM)..."
            git clone https://github.com/tmux-plugins/tpm "$tpm_dir" || warn "Failed to clone TPM."
        fi
        msg "Tmux configuration linked. TPM plugins will be installed on first 'prefix + I' inside a tmux session."
    fi

}
