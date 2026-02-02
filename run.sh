#!/bin/bash
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG="$BASE_DIR/config.json"

if [ ! -f "$CONFIG" ]; then
  echo "[ERROR] config.json not found"
  exit 1
fi

ENABLE=$(jq -r '.enable' "$CONFIG")
POOL=$(jq -r '.pool' "$CONFIG")
WALLET=$(jq -r '.wallet' "$CONFIG")
PASS=$(jq -r '.password' "$CONFIG")

if [ "$ENABLE" != "true" ]; then
  echo "[INFO] Mining disabled by config"
  exit 0
fi

exec "$BASE_DIR/bin/ccminer" \
  -a verus \
  -o "$POOL" \
  -u "$WALLET" \
  -p "$PASS" \
  -t 8
