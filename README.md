# 🦂 Anurag's Dotfiles

My personal development environment, fully automated for a quick and seamless setup on any new machine. This repository contains all the configuration files and installation scripts for my terminal, editor, and command-line tools.

The setup is designed to be idempotent and robust, meaning you can run the installer multiple times without causing issues.

<br>

<p align="center">
  <img src="https://raw.githubusercontent.com/Anurag-xo/dotfiles/main/.github/assets/showcase.png" alt="Showcase" />
</p>

---

## ✨ Features

- **Automated Installation**: A single script to set up everything on a fresh OS.
- **Cross-Platform**: Supports macOS, Ubuntu/Debian, and Arch/Manjaro Linux.
- **Modern Tools**: Configures a suite of modern, fast, and efficient command-line tools.
- **Sensible Keybindings**: Consistent and ergonomic keybindings across Neovim, Tmux, and Yazi.
- **Managed by Git**: All configurations are version-controlled, making them easy to update and maintain.

---

## 💻 Managed Software

The installation script will set up and configure the following software:

| Tool          | Description                               |
|---------------|-------------------------------------------|
| **Zsh**       | A powerful and interactive shell.         |
| **Neovim**    | A highly extensible, terminal-based text editor. |
| **Tmux**      | A terminal multiplexer for managing multiple sessions. |
| **WezTerm**   | A GPU-accelerated, cross-platform terminal emulator. |
| **Yazi**      | A blazingly fast terminal file manager.    |
| **Lazygit**   | A simple terminal UI for git commands.    |
| **Git**       | Version control system.                   |
| **Node.js**   | JavaScript runtime for various tools.     |
| **Ripgrep**   | A fast, line-oriented search tool.        |

---

## 🚀 Installation

### Prerequisites

Before running the installation script, you need to have `git` and `curl` installed on your system.

- **On Ubuntu/Debian**: `sudo apt update && sudo apt install -y git curl`
- **On Arch/Manjaro**: `sudo pacman -Syu --noconfirm git curl`
- **On macOS**: `xcode-select --install` will install Git.

### One-Liner Setup

To install and set up the dotfiles, clone this repository and run the `install.sh` script:

```bash
git clone https://github.com/Anurag-xo/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

The script will:
1.  Install all the necessary packages and dependencies.
2.  Create symbolic links for all configuration files.
3.  Install Neovim and Tmux plugins automatically.
4.  Set up the Yazi theme and configurations.

### Post-Installation

After the script completes, reload your shell to apply all changes:

```bash
exec zsh
```

---

## 🔧 Configuration Details

### Neovim

- **Plugin Manager**: [Lazy.nvim](https://github.com/folke/lazy.nvim)
- **Colorscheme**: [Catppuccin](https://github.com/catppuccin/nvim)
- **Keybindings**: For a detailed list of all keybindings, please refer to the [KEY_BINDINGS.md](./.config/nvim/KEY_BINDINGS.md) file.
- **LSP & Formatting**: Mason is used to manage LSPs, DAP, linters, and formatters, which are installed automatically.

### Tmux

- **Prefix**: `Ctrl + a`
- **Plugin Manager**: [TPM (Tmux Plugin Manager)](https://github.com/tmux-plugins/tpm)
- **Keybindings**:
    - `Prefix + |`: Split pane vertically.
    - `Prefix + -`: Split pane horizontally.
    - `Prefix + I`: To fetch/install plugins (this is done automatically by the install script).

### Yazi

- **Theme**: Catppuccin Mocha
- **File Previews**: Yazi is configured to show previews for images, code, and archives in the terminal.

---

## 🎨 Customization

The dotfiles are structured to be easily customizable.

- **Adding a new config file**:
    1.  Place your new configuration file in the appropriate directory (e.g., `.config/new-app/config.toml`).
    2.  Add a new line to `scripts/links.sh` to link it:
        ```bash
        link "$DOTFILES/.config/new-app/config.toml" "$HOME/.config/new-app/config.toml"
        ```
- **Installing a new package**:
    1.  Add the package name to the appropriate installation function in `scripts/packages.sh`.

---

## 📜 License

This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for details.