#!/bin/bash
#
# Main install script

# Source the helper scripts
source scripts/helpers.sh
source scripts/packages.sh
source scripts/links.sh

# Main function
main() {
  # Ask for sudo password upfront
  ask_for_sudo

  # Install packages
  install_packages

  # Create symlinks
  create_symlinks
}

main "$@"
