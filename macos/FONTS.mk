SVN_CELLAR:=/usr/local/Cellar/subversion
CASK_FONTS_TAP:=/usr/local/Homebrew/Library/Taps/homebrew/homebrew-cask-fonts

$(SVN_CELLAR):
	$(MAKE) $(BREW_PKG)/svn

$(CASK_FONTS_TAP): $(BREW)
	$(BREW) tap homebrew/cask-fonts

##################################################

CASK_FONTS:=\
	$(BREW_PKG)/font-fontawesome \
	$(BREW_PKG)/font-meslo-lg \
	$(BREW_PKG)/font-meslo-for-powerline \
	$(BREW_PKG)/font-source-code-pro \
	$(BREW_PKG)/font-source-code-pro-for-powerline

.DELETE_ON_ERROR: $(CASK_FONTS)
$(CASK_FONTS): $(CASK_FONTS_TAP) $(SVN_CELLAR) | $(BREW_PKG)
	$(BREW) install --cask $(@F) | tee $@; test $${PIPESTATUS[0]} -eq 0

##################################################

PASSWORD_FONT:=$(HOME)/Library/Fonts/Password.otf

$(PASSWORD_FONT): fonts/Password.otf
	cp $< $@

##################################################

SF_MONO_FONT:=/Library/Fonts/SF-Mono-Regular.otf

$(SF_MONO_FONT):
	sudo -v
	wget https://developer.apple.com/design/downloads/SF-Mono.dmg
	hdiutil attach SF-Mono.dmg
	sudo installer -pkg /Volumes/SFMonoFonts/SF\ Mono\ Fonts.pkg -target /
	hdiutil detach /Volumes/SFMonoFonts
	rm -rf SF-Mono.dmg