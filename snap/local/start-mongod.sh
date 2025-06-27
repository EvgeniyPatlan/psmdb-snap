#!/bin/bash
set -e

CONFIG_FILE="$SNAP_DATA/mongod.conf"
DATA_DIR="$SNAP_COMMON/var/lib/mongodb"
LOG_DIR="$SNAP_COMMON/var/log/mongodb"

mkdir -p "$DATA_DIR" "$LOG_DIR"

if [ ! -f "$CONFIG_FILE" ]; then
  cat <<EOF > "$CONFIG_FILE"
systemLog:
  destination: file
  path: "$LOG_DIR/mongod.log"
storage:
  dbPath: "$DATA_DIR"
net:
  bindIp: 0.0.0.0
  port: 27017
processManagement:
  fork: false
EOF
fi

exec "$SNAP/usr/bin/mongod" --config "$CONFIG_FILE"

