HOMEBREW_INSTALLER:="https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"

$(BREW): | $(BASH)
	sudo -v
	curl -fsSL $(HOMEBREW_INSTALLER) | $(BASH)
	brew update
	brew upgrade

##################################################

HOMEBREW_PACKAGES:=\
	$(BREW_PKG)/fzf \
	$(BREW_PKG)/git \
	$(BREW_PKG)/htop \
	$(BREW_PKG)/jq \
	$(BREW_PKG)/mas \
	$(BREW_PKG)/neovim \
	$(BREW_PKG)/node \
	$(BREW_PKG)/rg \
	$(BREW_PKG)/sshfs \
	$(BREW_PKG)/svn \
	$(BREW_PKG)/tmux \
	$(BREW_PKG)/wget \
	$(BREW_PKG)/zsh

.DELETE_ON_ERROR: $(HOMEBREW_PACKAGES)
$(HOMEBREW_PACKAGES): $(BREW) | $(BREW_PKG)
	$(BREW) install $(@F) | tee $@; test $${PIPESTATUS[0]} -eq 0

$(BREW_PKG)/sshfs: $(BREW_PKG)/osxfuse

.DELETE_ON_ERROR: $(BREW_PKG)/logitech-options
$(BREW_PKG)/logitech-options: $(BREW) | $(BREW_PKG)
	$(BREW) install homebrew/cask-drivers/logitech-options | tee $@; test $${PIPESTATUS[0]} -eq 0

.DELETE_ON_ERROR: $(BREW_PKG)/fzf-complete
$(BREW_PKG)/fzf-complete: $(BREW_PKG)/fzf
	/usr/local/opt/fzf/install --all | tee $@; test $${PIPESTATUS[0]} -eq 0

HOMEBREW_PACKAGES:=$(HOMEBREW_PACKAGES) $(BREW_PKG)/logitech-options $(BREW_PKG)/fzf-complete

##################################################

CASK_PACKAGES:=\
	$(BREW_PKG)/anaconda \
	$(BREW_PKG)/bitwarden \
	$(BREW_PKG)/bluejeans \
	$(BREW_PKG)/cryptomator \
	$(BREW_PKG)/docker \
	$(BREW_PKG)/drawio \
	$(BREW_PKG)/dropbox \
	$(BREW_PKG)/firefox \
	$(BREW_PKG)/forklift \
	$(BREW_PKG)/iterm2 \
	$(BREW_PKG)/microsoft-outlook \
	$(BREW_PKG)/microsoft-teams \
	$(BREW_PKG)/nordvpn \
	$(BREW_PKG)/notion \
	$(BREW_PKG)/numi \
	$(BREW_PKG)/osxfuse \
	$(BREW_PKG)/skype-for-business \
	$(BREW_PKG)/slack \
	$(BREW_PKG)/spotify \
	$(BREW_PKG)/sourcetree \
	$(BREW_PKG)/switchhosts \
	$(BREW_PKG)/tiles \
	$(BREW_PKG)/visual-studio-code \
	$(BREW_PKG)/webex-meetings \
	$(BREW_PKG)/whatsapp

.DELETE_ON_ERROR: $(CASK_PACKAGES)
$(CASK_PACKAGES): $(BREW) | $(BREW_PKG)
	$(BREW) install --cask $(@F) | tee $@; test $${PIPESTATUS[0]} -eq 0