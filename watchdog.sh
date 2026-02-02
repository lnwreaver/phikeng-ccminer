#!/bin/bash
# ===============================
# GM VERUS FARM - WATCHDOG
# ===============================

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
RUNNER="$BASE_DIR/run.sh"
LOGDIR="$BASE_DIR/logs"

mkdir -p "$LOGDIR"

while true; do
  if ! pgrep -f "$BASE_DIR/bin/ccminer" > /dev/null; then
    echo "[WATCHDOG] ccminer not running, starting..." | tee -a "$LOGDIR/watchdog.log"
    bash "$RUNNER" >> "$LOGDIR/miner.log" 2>&1
  fi
  sleep 10
done
