OH_MY_ZSH:=$(HOME)/.oh-my-zsh
OH_MY_ZSH_INSTALLER:="https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh"
POWERLEVEL10K_THEME:=/usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme

$(ZSHRC):
	$(MAKE) $(BREW_PKG)/zsh

$(OH_MY_ZSH): | $(ZSHRC) $(BASH)
	curl -fsSL $(OH_MY_ZSH_INSTALLER) | $(BASH)

$(POWERLEVEL10K_THEME): | $(ZSHRC)
	brew install romkatv/powerlevel10k/powerlevel10k
	echo "source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme" >> $(ZSHRC)