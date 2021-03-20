BASH:=/bin/bash
BREW:=/usr/local/Homebrew/bin/brew
NODE:=/usr/local/bin/node
NPM:=/usr/local/bin/npm
CONDA:=/usr/local/anaconda3/bin/conda
POETRY:=$(HOME)/.poetry/bin/poetry
ZSHRC:=$(HOME)/.zshrc

BREW_PKG:=.done/brew
CONDA_PKG:=.done/conda
NPM_PKG:=.done/npm

$(BREW_PKG) $(CONDA_PKG) $(NPM_PKG):
	mkdir -p $@

# IMPORTANT: include all .mk files in the beginning
include *.mk
include ../nvim/NVIM.mk

.PHONY: xcode
xcode:
	-xcode-select --install
	@echo "Press any key after Xcode CLI tools have finished installing..."
	@read ANYKEY

.PHONY: homebrew_packages
homebrew_packages: $(HOMEBREW_PACKAGES) $(CASK_PACKAGES)

.PHONY: npm_packages
npm_packages: $(NPM_PACKAGES)

.PHONY: conda_packages
conda_packages: $(CONDA_PACKAGES) $(CONDA_FORGE_PACKAGES)

$(POETRY):
	curl -sSL "https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py" | python -

.PHONY: fonts
fonts: $(CASK_FONTS) $(SF_MONO_FONT)

.PHONY: setup_zsh
setup_zsh: $(OH_MY_ZSH) $(POWERLEVEL10K_THEME)

.PHONY: setup_conda
setup_conda: $(CONDA)
	$(CONDA) init bash zsh

.PHONY: setup_nvim
setup_nvim: $(DOTCONFIG_DIR)/nvim

.PHONY: setup_prefs
setup_prefs:
	defaults write com.apple.finder ShowPathbar -bool YES    # Adds the path bar to the bottom of Finder
	defaults write com.apple.finder ShowStatusBar -bool YES  # Shows Status Bar in Finder
	defaults write com.apple.dock autohide -bool YES         # Turns Dock Autohide ON
	killall dock Finder

.PHONY: all
all: \
	xcode \
	homebrew_packages \
	npm_packages \
	conda_packages \
	$(POETRY) \
	fonts \
	setup_zsh \
	setup_conda \
	setup_nvim \
	setup_prefs

.PHONY: clean
clean:
	rm -rfv $(BREW_PKG) $(CONDA_PKG) $(NPM_PKG)