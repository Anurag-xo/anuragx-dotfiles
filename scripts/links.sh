#!/bin/bash
#
# Symlink creation

# ---
# Variables
# ---
DOTFILES=(
  "bashrc"
  "p10k.zsh"
  "tmux.conf"
  "wezterm.lua"
  "zshenv"
  "zshrc"
)

CONFIG_FILES=(
  "lazygit"
  "nvim"
  "yazi"
)

# ---
# Main symlink function
# ---
create_symlinks() {
  info "Creating symlinks..."

  # Dotfiles in home directory
  for file in "${DOTFILES[@]}"; do
    source_file="$DOTFILES_DIR/dot_$file"
    target_file="$HOME/.$file"
    if [ -e "$target_file" ]; then
      info "Backing up existing $target_file to $target_file.bak"
      mv "$target_file" "$target_file.bak"
    fi
    ln -s "$source_file" "$target_file"
  done

  # Config files in .config directory
  if [ ! -d "$XDG_CONFIG_HOME" ]; then
    mkdir -p "$XDG_CONFIG_HOME"
  fi

  for dir in "${CONFIG_FILES[@]}"; do
    source_dir="$DOTFILES_DIR/dot_config/$dir"
    target_dir="$XDG_CONFIG_HOME/$dir"
    if [ -e "$target_dir" ]; then
      info "Backing up existing $target_dir to $target_dir.bak"
      mv "$target_dir" "$target_dir.bak"
    fi
    ln -s "$source_dir" "$target_dir"
  done

  success "Symlinks created."
}
