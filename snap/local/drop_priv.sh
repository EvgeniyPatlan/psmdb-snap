#!/bin/bash
set -e

CMD="$1"
shift

exec sudo -u snap_daemon \
  env PATH="$SNAP/bin:$PATH" \
  HOME="$SNAP_USER_COMMON" \
  "$SNAP/usr/bin/$CMD" "$@"

