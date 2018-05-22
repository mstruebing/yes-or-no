################################################################################
# Variables
################################################################################


# Add node_modules binaries to $PATH
export PATH := ./node_modules/.bin:$(PATH)

SRC_DIR = src
SOURCES = $(shell find $(SRC_DIR) -type f -name '*.js')


################################################################################
# Setup
################################################################################


check-requirements:
	@which yarn &>/dev/null || \
		(echo yarn is not installed: https://github.com/yarnpkg/yarn && false)

# doesn't work fully as expected (rebuilding)
node_modules: package.json yarn.lock
	yarn install

install: node_modules

setup: check-requirements install build start


################################################################################
# Builds
################################################################################


start: 
	nodemon --watch dist index.js

# doesn't work fully as expected (rebuilding)
dist: $(SOURCES)
	babel src --out-dir dist --source-maps inline --presets=env --ignore test.js

build: dist

build-watch:
	babel src --out-dir dist --source-maps inline --presets=env --ignore test.js --watch


build-production:
	@echo TODO


################################################################################
# Code Quality
################################################################################


test:
	jest src

test-coverage:
	jest --coverage src

lint: lint-js lint-editorconfig

lint-js:
	xo

lint-editorconfig:
	editorconfig-checker

lint-fix:
	xo --fix
