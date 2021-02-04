#!/usr/bin/env bash

declare -r MYCONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd -P)"

# Add symlink for nvim configuration
mkdir -p "$HOME/.config"
ln -s "$MYCONFIG_DIR/nvim" "$HOME/.config/nvim"
