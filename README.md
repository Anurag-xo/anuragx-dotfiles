# Anurag's Dotfiles

These are my personal dotfiles, designed to be portable and easy to set up on a new machine. They provide a consistent development environment across different systems.

## What's Included?

This setup configures the following tools:

- **Shell**: Zsh with a custom configuration, powered by `zinit` for plugin management.
- **Terminal**: WezTerm with a custom theme and keybindings.
- **Multiplexer**: Tmux with a custom configuration for session management.
- **Editor**: Neovim with a modern, LSP-powered configuration based on LazyVim.
- **File Manager**: Yazi for a fast, terminal-based file navigation experience.
- **Git**: Lazygit for an interactive and user-friendly git interface.
- **Package Management**: An installation script that supports Arch Linux, Debian-based systems, and macOS.

## Installation

Setting up these dotfiles on a new machine is a simple, automated process.

### Prerequisites

Before you begin, ensure you have the following tools installed:

- `git`
- `curl`

These are typically pre-installed on most Linux distributions and macOS.

### Setup Command

Run the following command in your terminal to install and apply the dotfiles:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply anurag-xo
```

This single command performs the following steps:

1.  **Installs `chezmoi`**: A powerful tool for managing dotfiles across multiple machines.
2.  **Clones the repository**: Downloads this dotfiles repository to `~/.local/share/chezmoi`.
3.  **Applies the dotfiles**: Symlinks the configuration files to your home directory.
4.  **Installs packages**: Runs the `install.sh` script to install all the necessary applications and tools for your operating system.

### Post-Installation Steps

After the installation script finishes, you should:

1.  **Restart your terminal**: This will ensure that all the new settings, especially for Zsh, are loaded correctly.
2.  **Open Neovim**: The first time you run `nvim`, the Lazy.nvim plugin manager will automatically install all the configured plugins.
3.  **Start a Zsh session**: Run `zsh` to allow `zinit` to initialize and install any Zsh plugins.

## Customization

To make local changes to your dotfiles, you can use the `chezmoi` command. This allows you to edit the source files, and `chezmoi` will handle the symlinking.

- `chezmoi edit <file>`: Edit a file in your `chezmoi` source directory. For example, `chezmoi edit .zshrc`.
- `chezmoi cd`: Open a shell in your `chezmoi` source directory (`~/.local/share/chezmoi`).
- `chezmoi apply`: Apply your changes to the target directory (your home directory).

After making changes, commit them to your git repository to make them available on other machines.

## Repository Structure

The repository is organized as follows:

- `.config/`: Contains configuration files for tools like Neovim (`nvim`) and Yazi.
- `scripts/`: Holds helper scripts for installation, package management, and symlinking.
- `install.sh`: The main installation script that sets up the environment.
- Other files in the root directory (e.g., `.zshrc`, `.tmux.conf`) are the configuration files for various tools.
