# My Dotfiles

This repository contains my personal dotfiles, managed by [`chezmoi`](https://chezmoi.io). It allows for quick and easy setup of a new machine.

## Prerequisites

Before you begin, ensure you have the following installed on your new machine:

*   `git`: To clone the repository.
*   `chezmoi`: To manage the dotfiles.

You can typically install these with your system's package manager. For example, on a Debian-based system:

```bash
sudo apt-get update
sudo apt-get install git chezmoi
```

## Installation

1.  **Initialize `chezmoi` with this repository:**

    This command will clone the repository and initialize `chezmoi` with it.

    ```bash
    chezmoi init https://github.com/your-username/your-dotfiles-repo.git
    ```

    Replace `https://github.com/your-username/your-dotfiles-repo.git` with the actual URL of this repository.

2.  **Apply the dotfiles:**

    This command will create the symbolic links and apply the configurations to your home directory.

    ```bash
    chezmoi apply
    ```

## Package Management

This repository is set up to handle package installation, but it requires some manual configuration.

1.  **Create a package installation script:**

    Create a file named `install-packages.sh` in the `.chezmoi.d/run_once` directory. This script will be executed by `chezmoi` only once, when you first set up your machine.

    ```bash
mkdir -p ~/.local/share/chezmoi/.chezmoi.d/run_once
touch ~/.local/share/chezmoi/.chezmoi.d/run_once/run_once_install-packages.sh
chmod +x ~/.local/share/chezmoi/.chezmoi.d/run_once/run_once_install-packages.sh
    ```

2.  **Add your packages to the script:**

    Open the `run_once_install-packages.sh` file and add the commands to install your desired packages. Here is a template to get you started:

    ```bash
#!/bin/bash

# Detect package manager
if command -v apt-get &>/dev/null; then
  # Debian/Ubuntu
  sudo apt-get update
  sudo apt-get install -y \
    build-essential \
    neovim \
    tmux \
    zsh
elif command -v dnf &>/dev/null; then
  # Fedora
  sudo dnf install -y \
    neovim \
    tmux \
    zsh
else
  echo "Unsupported package manager. Please install packages manually."
fi
    ```

3.  **Run `chezmoi apply` again:**

    `chezmoi` will detect the new script and execute it.

    ```bash
    chezmoi apply
    ```

## Secrets Management

This repository uses `chezmoi`'s templating feature to manage secrets, such as the `GEMINI_API_KEY`.

The `.zshrc` file contains the following template:

```
{{- if (and (stat (joinPath .chezmoi.homeDir ".config" "gcloud" "application_default_credentials.json"))) }}
export GEMINI_API_KEY=$(gcloud auth application-default print-access-token)
{{- end }}
```

To make this work, you need to:

1.  **Install the Google Cloud CLI:**

    Follow the official instructions to install the `gcloud` CLI on your system.

2.  **Authenticate with Google Cloud:**

    Run the following command and follow the instructions to log in to your Google account:

    ```bash
    gcloud auth application-default login
    ```

    This will create the `application_default_credentials.json` file, and the template in your `.zshrc` will then be able to export the `GEMINI_API_KEY`.

## Customization

To add new dotfiles or modify existing ones, use the `chezmoi` command.

*   **Add a new file:**

    ```bash
    chezmoi add ~/.new-config-file
    ```

*   **Edit a file:**

    ```bash
    chezmoi edit ~/.config-file-to-edit
    ```

    This will open the file in your default editor. After you save and close the file, the changes will be stored in the `chezmoi` source directory.

*   **Apply your changes:**

    ```bash
    chezmoi apply
    ```

## Troubleshooting

If you encounter issues with `chezmoi` automatically trying to run installation scripts, you can try the following:

*   Create a `.chezmoiignore` file in the root of the repository and add the names of any scripts you want `chezmoi` to ignore.
*   Create an empty `run_once_install-packages.sh` script in the `.chezmoi.d/run_once` directory to prevent `chezmoi` from running its own package installation scripts.
*   Create an empty `install-packages.sh` file in a `.chezmoitemplates` directory to override the built-in template.
