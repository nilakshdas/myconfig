#!/usr/bin/env bash

declare -r MYCONFIG_DIR="$(pwd)"

# Add symlink for nvim configuration
mkdir -p "$HOME/.config/nvim"
ln -sf "$MYCONFIG_DIR/nvim/init.vim" "$HOME/.config/nvim/init.vim"
