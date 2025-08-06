#!/bin/bash
# scripts/packages.sh

set -e # Exit immediately if a command exits with a non-zero status.

# Function to install packages on Ubuntu/Debian-based systems
install_ubuntu() {
    echo "Installing packages for Ubuntu/Debian..."

    # Update package list
    sudo apt update

    # Install packages available via apt
    # Note: 'cargo' is removed from this list as we install yazi via binary
    sudo apt install -y neovim tmux lazygit zsh nodejs npm wezterm ripgrep build-essential curl unzip

    # --- Install Yazi via Pre-built Binary ---
    echo "Installing Yazi from pre-built binary..."
    YAZI_VERSION=$(curl -s "https://api.github.com/repos/sxyazi/yazi/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    if [[ -z "$YAZI_VERSION" ]]; then
        echo "Error: Could not fetch the latest Yazi version."
        return 1
    else
        # Determine architecture
        YAZI_ARCH=""
        case $(uname -m) in
            x86_64)  YAZI_ARCH="x86_64" ;;
            aarch64) YAZI_ARCH="aarch64" ;;
            # armv7l)  YAZI_ARCH="armv7l" ;; # Uncomment if Yazi provides this and you need it
            *)
                echo "Error: Unsupported architecture $(uname -m) for pre-built Yazi binary."
                return 1
                ;;
        esac

        YAZI_URL="https://github.com/sxyazi/yazi/releases/latest/download/yazi-linux-${YAZI_ARCH}.zip"
        TMP_DIR=$(mktemp -d)
        if [[ ! "$TMP_DIR" || ! -d "$TMP_DIR" ]]; then
            echo "Error: Could not create temporary directory for Yazi."
            return 1
        fi

        function yazi_cleanup {
            rm -rf "$TMP_DIR" 2>/dev/null
        }
        trap yazi_cleanup EXIT

        if curl -sL "$YAZI_URL" -o "$TMP_DIR/yazi.zip" && unzip -q "$TMP_DIR/yazi.zip" -d "$TMP_DIR"; then
            # Locate the yazi binary within the extracted folder
            # The structure might be yazi-linux-<arch>/yazi or just yazi
            YAZI_BINARY_PATH=""
            if [[ -f "$TMP_DIR/yazi" ]]; then
                YAZI_BINARY_PATH="$TMP_DIR/yazi"
            elif [[ -f "$TMP_DIR/yazi-linux-${YAZI_ARCH}/yazi" ]]; then
                YAZI_BINARY_PATH="$TMP_DIR/yazi-linux-${YAZI_ARCH}/yazi"
            else
                echo "Error: Could not find 'yazi' binary in the extracted archive ($TMP_DIR)."
                ls -la "$TMP_DIR" "$TMP_DIR/yazi-linux-${YAZI_ARCH}" 2>/dev/null || echo "Debug: Checked directories."
                return 1
            fi

            INSTALL_DIR_YAZI="$HOME/.local/bin"
            mkdir -p "$INSTALL_DIR_YAZI"
            if install -m 755 "$YAZI_BINARY_PATH" "$INSTALL_DIR_YAZI/"; then
                 echo "Yazi installed successfully to $INSTALL_DIR_YAZI"
                 # Verify
                 if command -v yazi &> /dev/null; then
                     echo "Verification: 'yazi' command found."
                 else
                     echo "Warning: 'yazi' command not found in PATH after installation."
                     echo "         Ensure $INSTALL_DIR_YAZI is in your shell's PATH."
                     echo "         Check your ~/.zshrc for 'export PATH=\"\$HOME/.local/bin:\$PATH\"'"
                 fi
            else
                 echo "Error: Failed to install Yazi binary to $INSTALL_DIR_YAZI"
                 return 1
            fi
        else
            echo "Error: Failed to download or extract Yazi from $YAZI_URL"
            return 1
        fi
        trap - EXIT # Remove trap if successful
    fi
    # --- End Yazi Installation ---
}

# Function to install packages on Arch Linux-based systems
install_arch() {
    echo "Installing packages for Arch Linux..."
    # Install packages available via pacman
    # Note: 'yazi' is removed from the direct pacman install list to use the binary method for consistency.
    # You can add it back: sudo pacman -Syu --noconfirm yazi
    sudo pacman -Syu --noconfirm neovim tmux lazygit wezterm zsh git nodejs npm ripgrep curl unzip

    # --- Install Yazi via Pre-built Binary (Optional for Arch, if preferred over pacman package) ---
    # You can copy the Yazi installation logic from install_ubuntu here if needed for Arch.
    # Or rely on pacman if you uncomment 'yazi' above.
    # For now, assuming pacman handles it or you'll adapt the Ubuntu logic.
    echo "Installing Yazi from pre-built binary (Arch)..."
    # Reuse Ubuntu logic for Arch binary install
    # (This part is intentionally left as a copy of the Ubuntu logic for consistency)
    YAZI_VERSION=$(curl -s "https://api.github.com/repos/sxyazi/yazi/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    if [[ -z "$YAZI_VERSION" ]]; then
        echo "Error: Could not fetch the latest Yazi version (Arch)."
        return 1
    else
        YAZI_ARCH=""
        case $(uname -m) in
            x86_64)  YAZI_ARCH="x86_64" ;;
            aarch64) YAZI_ARCH="aarch64" ;;
            # armv7l)  YAZI_ARCH="armv7l" ;;
            *)
                echo "Error: Unsupported architecture $(uname -m) for pre-built Yazi binary (Arch)."
                return 1
                ;;
        esac

        YAZI_URL="https://github.com/sxyazi/yazi/releases/latest/download/yazi-linux-${YAZI_ARCH}.zip"
        TMP_DIR=$(mktemp -d)
        if [[ ! "$TMP_DIR" || ! -d "$TMP_DIR" ]]; then
            echo "Error: Could not create temporary directory for Yazi (Arch)."
            return 1
        fi

        function yazi_cleanup_arch {
            rm -rf "$TMP_DIR" 2>/dev/null
        }
        trap yazi_cleanup_arch EXIT

        if curl -sL "$YAZI_URL" -o "$TMP_DIR/yazi.zip" && unzip -q "$TMP_DIR/yazi.zip" -d "$TMP_DIR"; then
            YAZI_BINARY_PATH=""
            if [[ -f "$TMP_DIR/yazi" ]]; then
                YAZI_BINARY_PATH="$TMP_DIR/yazi"
            elif [[ -f "$TMP_DIR/yazi-linux-${YAZI_ARCH}/yazi" ]]; then
                 YAZI_BINARY_PATH="$TMP_DIR/yazi-linux-${YAZI_ARCH}/yazi"
            else
                echo "Error: Could not find 'yazi' binary in the extracted archive (Arch)."
                ls -la "$TMP_DIR" "$TMP_DIR/yazi-linux-${YAZI_ARCH}" 2>/dev/null || echo "Debug: Checked directories (Arch)."
                return 1
            fi

            INSTALL_DIR_YAZI="$HOME/.local/bin"
            mkdir -p "$INSTALL_DIR_YAZI"
            if install -m 755 "$YAZI_BINARY_PATH" "$INSTALL_DIR_YAZI/"; then
                 echo "Yazi installed successfully to $INSTALL_DIR_YAZI (Arch)"
                 if command -v yazi &> /dev/null; then
                     echo "Verification: 'yazi' command found (Arch)."
                 else
                     echo "Warning: 'yazi' command not found in PATH after installation (Arch)."
                     echo "         Ensure $INSTALL_DIR_YAZI is in your shell's PATH."
                 fi
            else
                 echo "Error: Failed to install Yazi binary to $INSTALL_DIR_YAZI (Arch)"
                 return 1
            fi
        else
            echo "Error: Failed to download or extract Yazi from $YAZI_URL (Arch)"
            return 1
        fi
        trap - EXIT
    fi
    # --- End Yazi Installation (Arch) ---
}


# Main script logic to detect OS and call the appropriate function
main() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Detect specific Linux distribution
        if command -v lsb_release &> /dev/null; then
            DISTRO=$(lsb_release -si)
        elif [[ -f /etc/os-release ]]; then
            . /etc/os-release
            DISTRO=$ID
        else
            echo "Warning: Could not detect Linux distribution. Assuming Ubuntu/Debian-like."
            DISTRO="unknown"
        fi

        case $DISTRO in
            Ubuntu|Debian|Pop|Kali|LinuxMint)
                install_ubuntu
                ;;
            Arch|Manjaro|EndeavourOS)
                install_arch
                ;;
            *)
                echo "Warning: Unsupported or untested Linux distribution: $DISTRO. Trying Ubuntu method."
                install_ubuntu
                ;;
        esac
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macOS detected. Please ensure Homebrew is installed and packages are managed via 'brew'."
        echo "Consider adding 'brew install lazygit yazi' to your setup for macOS."
        # Add macOS specific installation logic here if needed
    else
        echo "Unsupported operating system: $OSTYPE"
        exit 1
    fi
}

# Run the main function
main
