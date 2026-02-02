#!/bin/bash
# ================================
# GM VERUS FARM - watchdog.sh (FINAL)
# ================================

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
RUN="$BASE_DIR/run.sh"
LOG="$BASE_DIR/logs/watchdog.log"

INTERVAL=20   # วินาที

mkdir -p "$BASE_DIR/logs"

echo "[WATCHDOG] Started at $(date)" >> "$LOG"

while true; do
  if pgrep -f "$BASE_DIR/bin/ccminer" > /dev/null; then
    sleep "$INTERVAL"
    continue
  fi

  echo "[WATCHDOG] ccminer not running, restarting..." >> "$LOG"
  bash "$RUN" &
  sleep "$INTERVAL"
done
