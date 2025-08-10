# Anurag's Dotfiles

These are my personal dotfiles, managed by [chezmoi](https://chezmoi.io). They are designed to be portable and easy to set up on a new machine.

## Features

- **Shell**: Zsh with a custom configuration.
- **Terminal**: WezTerm with a custom theme and keybindings.
- **Multiplexer**: Tmux with a custom configuration.
- **Editor**: Neovim with a custom configuration based on LazyVim.
- **File Manager**: Yazi with a custom theme.
- **Git**: Lazygit for an improved git experience.
- **Package Management**: An installation script that supports Arch Linux, Debian-based systems, and macOS.

## Installation

To set up these dotfiles on a new machine, you only need to run a single command:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply anurag-xo
```

This command will:

1.  Install `chezmoi`.
2.  Initialize the `chezmoi` repository from this git repository.
3.  Apply the dotfiles to your home directory.
4.  Run the package installation script to install all the necessary tools.

## Customization

To make local changes to your dotfiles, you can use the `chezmoi` command:

- `chezmoi edit <file>`: Edit a file in your `chezmoi` source directory.
- `chezmoi cd`: Open a shell in your `chezmoi` source directory.
- `chezmoi apply`: Apply your changes.

After making changes, commit them to your git repository to make them available on other machines.
