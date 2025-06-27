#!/bin/bash

# Set high resource limits
ulimit -SHf unlimited
ulimit -SHt unlimited
ulimit -SHv unlimited
ulimit -SHm unlimited
ulimit -Sl unlimited
ulimit -SHn 64000
ulimit -SHu 64000

CONFIG_FILE="$SNAP_DATA/mongos.conf"
LOG_DIR="$SNAP_COMMON/var/log/mongos"

mkdir -p "$LOG_DIR"

# Create default config if not exists
if [ ! -f "$CONFIG_FILE" ]; then
  cat <<EOF > "$CONFIG_FILE"
systemLog:
  destination: file
  path: "$LOG_DIR/mongos.log"
net:
  bindIp: 0.0.0.0
  port: 27017
sharding:
  configDB: rs0/localhost:27019
EOF
fi

# Allow passing additional args via snap set
SNAP_ARGS="$(snapctl get mongos-args)"
if [[ -n "${SNAP_ARGS}" ]]; then
    MONGOS_ARGS="${SNAP_ARGS}"
fi

# Drop privileges and run mongos
exec "$SNAP/usr/bin/setpriv" --clear-groups --reuid snap_daemon \
  --regid snap_daemon -- "$SNAP/usr/bin/mongos" \
  --config "$CONFIG_FILE" ${MONGOS_ARGS} "$@"

