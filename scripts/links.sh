#!/bin/bash
DOTFILES=$HOME/.dotfiles
XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}

link() {
  local src=$1 dst=$2
  mkdir -p "$(dirname "$dst")"
  ln -sf "$src" "$dst"
  echo "🔗 $dst → $src"
}

# Shell
link "$DOTFILES/.zshenv" "$HOME/.zshenv"
link "$DOTFILES/.zshrc" "$HOME/.zshrc"
link "$DOTFILES/.bashrc" "$HOME/.bashrc"

# Tmux
link "$DOTFILES/.tmux.conf" "$HOME/.tmux.conf"

# WezTerm
link "$DOTFILES/.wezterm.lua" "$HOME/.wezterm.lua"

# Lazygit
link "$DOTFILES/lazygit/config.yml" "$XDG_CONFIG_HOME/lazygit/config.yml"

# Yazi
link "$DOTFILES/yazi/keymap.toml" "$XDG_CONFIG_HOME/yazi/keymap.toml"
link "$DOTFILES/yazi/options.toml" "$XDG_CONFIG_HOME/yazi/options.toml"
link "$DOTFILES/yazi/theme.toml" "$XDG_CONFIG_HOME/yazi/theme.toml"

# Neovim (use ~/.config/nvim)
link "$DOTFILES/nvim" "$XDG_CONFIG_HOME/nvim"

# Stylua
link "$DOTFILES/nvim/.stylua.toml" "$HOME/.stylua.toml"

echo "✅ All configs linked."
