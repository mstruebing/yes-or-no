################################################################################
# Variables
################################################################################


# Add node_modules binaries to $PATH
export PATH := ./node_modules/.bin:$(PATH)


################################################################################
# Setup
################################################################################


check-requirements:
	@which yarn &>/dev/null || \
		(echo yarn is not installed: https://github.com/yarnpkg/yarn && false)

install:
	yarn install

setup: check-requirements install


################################################################################
# Builds
################################################################################


build:
	@echo TODO

watch:
	@echo TODO

build-production:
	@echo TODO


################################################################################
# Code Quality
################################################################################


test:
	@echo TODO

lint: lint-js lint-editorconfig

lint-js:
	xo

lint-editorconfig:
	editorconfig-checker


################################################################################
# Misc
################################################################################


.PHONY: clean
clean:
	rm -Rf node_modules
