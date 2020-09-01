#!/usr/bin/env bash

cd ~
sudo -v

# Install Xcode CLI tools
xcode-select --install
echo "Press any key after Xcode CLI tools have finished installing..."
read ANYKEY

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew update
brew upgrade

# Install brew packages
HOMEBREW_PACKAGES=(
    fzf
    git
    htop
    mas
    neovim
    node
    rg
    tmux
    wget
    zsh
)
brew install ${HOMEBREW_PACKAGES[@]}

# Install brew cask packages
HOMEBREW_CASK_PACKAGES=(
    1clipboard
    anaconda
    cryptomator
    docker
    firefox
    forklift
    iterm2
    lastpass
    nordvpn
    spotify
    sourcetree
    switchhosts
    tiles
    visual-studio-code
)
brew cask install ${HOMEBREW_CASK_PACKAGES[@]}

# Install npm packages
NPM_PACKAGES=(
    eslint
    yarn
)
npm install -g ${NPM_PACKAGES[@]}

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Setup Powerlevel10k theme
brew install romkatv/powerlevel10k/powerlevel10k
echo 'source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme' >>! ~/.zshrc

# Setup fzf
/usr/local/opt/fzf/install --all

# Initialize conda
conda init bash zsh
source ~/.bashrc
source ~/.zshrc

# Install SSHFS
brew cask install osxfuse
brew install sshfs

# Setup fonts
brew tap homebrew/cask-fonts
HOMEBREW_FONTS=(
    font-fontawesome
    font-meslo-lg
    font-meslolg-nerd-font
    font-meslo-for-powerline
    font-source-code-pro
    font-source-code-pro-for-powerline
)
brew cask install ${HOMEBREW_FONTS[@]}

wget https://developer.apple.com/design/downloads/SF-Mono.dmg
hdiutil attach SF-Mono.dmg
sudo installer -pkg /Volumes/SFMonoFonts/SF\ Mono\ Fonts.pkg -target /
hdiutil detach /Volumes/SFMonoFonts
rm -rf SF-Mono.dmg

# Overwrite MacOS settings
defaults write com.apple.finder ShowPathbar -bool true          # Adds the path bar to the bottom of Finder
defaults write com.apple.finder ShowStatusBar -bool YES         # Shows Status Bar in Finder

defaults write com.apple.dock autohide -bool true               # Turns Dock Autohide ON
defaults write com.apple.dock minimize-to-application -bool YES # Minimize applications to their respective application icon

killall dock
killall Finder

# Source rc files
source ~/.bashrc
source ~/.zshrc