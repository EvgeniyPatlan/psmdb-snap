# Project Makefile for percona-distribution-mongodb-80 Snap

SNAP_NAME := percona-distribution-mongodb-80
SNAP_FILE := $(SNAP_NAME)_*.snap

.PHONY: all build clean install remove logs lint shell

all: build

## Build the Snap
build:
	snapcraft --use-lxd

## Install the built Snap locally (using the latest .snap file)
install: build
	sudo snap install --dangerous $(SNAP_FILE)

## Remove the Snap
remove:
	-sudo snap remove $(SNAP_NAME)

## Clean build artifacts
clean:
	rm -f *.snap
	rm -rf prime stage parts

## View Snap logs
logs:
	sudo snap logs $(SNAP_NAME)

## Lint the Snap (snapcraft review tools must be installed)
lint:
	snapcraft lint $(SNAP_FILE)

## Open an interactive shell in the Snapcraft build environment
shell:
	snapcraft --shell

## Set snap config value: make set CONFIG=pbm-uri VALUE="mongodb://localhost:27017"
set:
	sudo snap set $(SNAP_NAME) $(CONFIG)=$(VALUE)

## Unset snap config: make unset CONFIG=pbm-uri
unset:
	sudo snap unset $(SNAP_NAME) $(CONFIG)


