#!/usr/bin/env bash

set -xe

cd ~
sudo -v

# Update APT
sudo apt-get update -y
sudo apt upgrade -y

# Install apt packages
APT_GET_PACKAGES=(
    apt-transport-https
    fonts-powerline
    g++
    gcc
    git
    make
    powerline
    python-dev
    python-neovim
    python-pip
    python3-dev
    python3-neovim
    python3-pip
    snapd
    software-properties-common
    tmux
    zsh
)
sudo apt-get install -y ${APT_GET_PACKAGES[@]}

# Install nodejs
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs
NPM_PACKAGES=(
    eslint
    yarn
)
sudo npm install -g ${NPM_PACKAGES[@]}

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
sudo chsh -s /usr/bin/zsh $(whoami)

# Install anaconda
curl -O https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh
bash Anaconda3-2020.02-Linux-x86_64.sh
conda init bash zsh
rm Anaconda3-2020.02-Linux-x86_64.sh
source ~/.bashrc
source ~/.zshrc

# Install Syncthing
curl -s https://syncthing.net/release-key.txt | sudo apt-key add -
echo "deb https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
sudo apt-get update -y
sudo apt-get install -y syncthing

# Install ripgrep
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
sudo dpkg -i ripgrep_11.0.2_amd64.deb
rm ripgrep_11.0.2_amd64.deb

# Install neovim
sudo add-apt-repository -y ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install -y neovim

# Source rc files
source ~/.bashrc
source ~/.zshrc