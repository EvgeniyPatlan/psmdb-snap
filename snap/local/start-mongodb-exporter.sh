#!/bin/bash
set -e

MONGODB_URI=$(snapctl get mongodb-uri || true)

if [ -z "$MONGODB_URI" ]; then
  echo "Missing MongoDB URI. Please run:"
  echo "sudo snap set percona-mongodb mongodb-uri='mongodb://localhost:27017'"
  exit 1
fi

exec sudo -u snap_daemon \
  env PATH="$SNAP/bin:$PATH" \
  HOME="$SNAP_USER_COMMON" \
  MONGODB_URI="$MONGODB_URI" \
  "$SNAP/bin/mongodb_exporter"

