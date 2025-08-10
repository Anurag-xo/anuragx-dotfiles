#!/bin/bash
#
# Helper functions

# ---
# Variables
# ---

export DOTFILES_DIR
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

# ---
# Helper functions
# ---

# Ask for the administrator password upfront
ask_for_sudo() {
  info "Prompting for sudo password..."
  if sudo -v; then
    # Keep-alive: update existing sudo time stamp until the script has finished
    while true; do
      sudo -n true
      sleep 60
      kill -0 "$$" || exit
    done 2>/dev/null &
    success "Sudo password updated."
  else
    error "Failed to obtain sudo password."
  fi
}

# ---
# Logging functions
# ---

info() {
  printf "\r  [ \033[00;34m..\033[0m ] %s\n" "$1"
}

user() {
  printf "\r  [ \033[0;33m??\033[0m ] %s\n" "$1"
}

success() {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] %s\n" "$1"
}

error() {
  printf "\r\033[2K  [ \033[00;31mKO\033[0m ] %s\n" "$1"
  exit 1
}

