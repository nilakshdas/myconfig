#!/usr/bin/env bash

declare -r MYCONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd -P)"

# Add symlink for nvim configuration
mkdir -p "$HOME/.config/nvim"
ln -sf "$MYCONFIG_DIR/nvim/init.vim" "$HOME/.config/nvim/init.vim"
