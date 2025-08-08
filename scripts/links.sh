#!/usr/bin/env bash

# --- Symlink Creation ---

# Function to create all necessary symlinks
# This is where you define the mapping from your dotfiles repo to the home directory
create_links() {
    # Ensure DOTFILES_DIR is set (should be exported by install.sh)
    if [[ -z "$DOTFILES_DIR" ]]; then
        error "DOTFILES_DIR is not set. This script should be sourced by install.sh."
    fi

    # --- Link configuration directories ---
    link "$DOTFILES_DIR/.config/nvim"            "$HOME/.config/nvim"
    link "$DOTFILES_DIR/.config/zsh"             "$HOME/.config/zsh" # Assuming your zsh configs are here
    link "$DOTFILES_DIR/.config/tmux"            "$HOME/.config/tmux" # If you have a tmux config dir
    link "$DOTFILES_DIR/.config/wezterm"         "$HOME/.config/wezterm"
    link "$DOTFILES_DIR/.config/lazygit"         "$HOME/.config/lazygit"
    link "$DOTFILES_DIR/.config/yazi"            "$HOME/.config/yazi"
    # Add links for other .config subdirectories as needed


    # --- Link top-level dotfiles ---
    link "$DOTFILES_DIR/.zshrc"                  "$HOME/.zshrc"
    link "$DOTFILES_DIR/.tmux.conf"              "$HOME/.tmux.conf"
    # link "$DOTFILES_DIR/.p10k.zsh"            "$HOME/.p10k.zsh" # If separate, otherwise sourced from .zshrc
    # Add links for other top-level dotfiles (.gitconfig, .vimrc, etc.) if they exist in your repo
    # Example:
    # if [[ -f "$DOTFILES_DIR/.gitconfig" ]]; then
    #     link "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
    # fi


    # --- Link local/share or other locations if needed ---
    # Example for zinit (if you want to pre-clone it, though .zshrc usually handles it)
    # link "$DOTFILES_DIR/.local/share/zinit" "$HOME/.local/share/zinit"

    msg "Symlink creation process finished."
}
