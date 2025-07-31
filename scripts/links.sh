#!/bin/bash
DOTFILES=$HOME/.dotfiles
XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}

link() {
  local src="$1"
  local dst="$2"

  # Create parent directory
  mkdir -p "$(dirname "$dst")"

  # If target exists and is not a symlink, back it up
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    mv "$dst" "$dst.bak"
    echo "💾 Backed up $dst → $dst.bak"
  fi

  # Remove broken symlinks or outdated ones
  if [ -L "$dst" ] && [ "$(readlink "$dst")" != "$src" ]; then
    rm "$dst"
  fi

  # Create the symlink
  ln -sf "$src" "$dst"
  echo "🔗 $dst → $src"
}

link "$DOTFILES/.zshenv" "$HOME/.zshenv"
link "$DOTFILES/.zshrc" "$HOME/.zshrc"
link "$DOTFILES/.tmux.conf" "$HOME/.tmux.conf"
link "$DOTFILES/.wezterm.lua" "$HOME/.wezterm.lua"
link "$DOTFILES/.config/nvim" "$HOME/.config/nvim"
link "$DOTFILES/.config/yazi" "$HOME/.config/yazi"
link "$DOTFILES/.config/lazygit/config.yml" "$HOME/.config/lazygit/config.yml"

echo "✅ All configs linked."
