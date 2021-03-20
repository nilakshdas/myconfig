NVIM_MAKEFILE_PATH:=$(abspath $(lastword $(MAKEFILE_LIST)))

MYCONFIG_DIR:=$(abspath $(NVIM_MAKEFILE_PATH)/../..)
DOTCONFIG_DIR:=$(HOME)/.config

$(DOTCONFIG_DIR):
	mkdir -p $@

$(DOTCONFIG_DIR)/nvim: | $(DOTCONFIG_DIR)
	ln -s "$(MYCONFIG_DIR)/nvim" "$@"