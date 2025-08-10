# My Dotfiles

This repository contains my personal dotfiles for various applications, managed with a custom installation script and `chezmoi`.

## Structure

The repository is organized as follows:

*   **`dot_*` files:** These are the actual dotfiles, prefixed with `dot_`. The installation script will create symbolic links to these files in your home directory (e.g., `dot_bashrc` will be linked to `~/.bashrc`).
*   **`dot_config/`:** This directory contains configurations for applications that follow the XDG Base Directory Specification. The installation script will create symbolic links to these directories in your `~/.config` directory.
*   **`scripts/`:** This directory contains helper scripts for the installation process.
    *   **`helpers.sh`:** Contains helper functions for logging and other tasks.
    *   **`links.sh`:** Contains the logic for creating symbolic links.
    *   **`packages.sh`:** Contains the logic for installing packages.
*   **`install.sh`:** The main installation script.

## Installation

To install these dotfiles, run the following command:

```bash
./install.sh
```

The script will:

1.  Ask for your `sudo` password to install packages.
2.  Install the packages listed in `scripts/packages.sh`, including `chezmoi`.
3.  Create symbolic links for the dotfiles in your home directory and `~/.config` directory.

## `chezmoi`

This repository uses `chezmoi` to manage the dotfiles. The `install.sh` script will install `chezmoi` for you. While the `install.sh` script handles the initial setup, you can use `chezmoi` to manage your dotfiles going forward.

For example, to apply any changes you've made to your dotfiles, you can run:

```bash
chezmoi apply
```

## Customization

### Packages

The `scripts/packages.sh` script is set up to use `pacman` (Arch Linux) by default. If you are using a different package manager, you will need to edit this file and add the appropriate package names for your system.

### Dotfiles

You can customize the dotfiles by editing the files in the `dot_*` and `dot_config` directories.