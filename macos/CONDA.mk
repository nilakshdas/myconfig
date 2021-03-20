$(CONDA):
	$(MAKE) $(BREW_PKG)/anaconda

##################################################

CONDA_PACKAGES:=\
	$(CONDA_PKG)/black

.DELETE_ON_ERROR: $(CONDA_PACKAGES)
$(CONDA_PACKAGES): $(CONDA) | $(CONDA_PKG)
	$(CONDA) install -y $(@F) | tee $@; test $${PIPESTATUS[0]} -eq 0

##################################################

CONDA_FORGE_PACKAGES:=\
	$(CONDA_PKG)/jupyterlab \
	$(CONDA_PKG)/ncdu

.DELETE_ON_ERROR: $(CONDA_FORGE_PACKAGES)
$(CONDA_FORGE_PACKAGES): $(CONDA) | $(CONDA_PKG)
	$(CONDA) install -y -c conda-forge $(@F) | tee $@; test $${PIPESTATUS[0]} -eq 0