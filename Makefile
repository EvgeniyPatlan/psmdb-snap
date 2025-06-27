# Makefile for percona-distribution-mongodb-80 Snap

SNAP_NAME := percona-distribution-mongodb-80
SNAP_FILE := $(SNAP_NAME)_*.snap

.PHONY: all build clean install remove logs lint shell set unset

all: build

## Build Snap using destructive-mode (host system)
build:
	snapcraft --destructive-mode

## Install the built Snap locally
install: build
	sudo snap install --dangerous $(SNAP_FILE)

## Remove the Snap
remove:
	-sudo snap remove $(SNAP_NAME)

## Clean build artifacts
clean:
	rm -f *.snap
	rm -rf prime stage parts

## View logs
logs:
	sudo snap logs $(SNAP_NAME)

## Lint the snapcraft.yaml
lint:
	snapcraft lint snapcraft.yaml

## Shell into Snapcraft environment (not applicable in destructive-mode)
shell:
	@echo "Destructive mode does not support shell-in-build. Use 'make build' directly."

## Set a Snap config (e.g., make set CONFIG=pbm-uri VALUE="mongodb://localhost:27017")
set:
	sudo snap set $(SNAP_NAME) $(CONFIG)=$(VALUE)

## Unset a Snap config (e.g., make unset CONFIG=pbm-uri)
unset:
	sudo snap unset $(SNAP_NAME) $(CONFIG)
