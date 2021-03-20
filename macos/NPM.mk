$(NODE) $(NPM):
	$(MAKE) $(BREW_PKG)/node

##################################################

NPM_PACKAGES:=\
	$(NPM_PKG)/eslint \
	$(NPM_PKG)/yarn

.DELETE_ON_ERROR: $(NPM_PACKAGES)
$(NPM_PACKAGES): $(NPM) | $(NPM_PKG)
	npm install -g $(@F) | tee $@; test $${PIPESTATUS[0]} -eq 0