#!/bin/bash
# ================================
# GM VERUS FARM - run.sh (FINAL)
# ================================

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
BIN="$BASE_DIR/bin/ccminer"
CONF="$BASE_DIR/config.json"
LOG="$BASE_DIR/logs/miner.log"

THREADS=8

mkdir -p "$BASE_DIR/logs"

if [ ! -x "$BIN" ]; then
  echo "[RUN] ccminer not found or not executable" | tee -a "$LOG"
  exit 1
fi

if [ ! -f "$CONF" ]; then
  echo "[RUN] config.json not found" | tee -a "$LOG"
  exit 1
fi

POOL=$(jq -r '.pool' "$CONF")
WALLET=$(jq -r '.wallet' "$CONF")
PASS=$(jq -r '.password' "$CONF")
ALGO=$(jq -r '.algo' "$CONF")

echo "========================================" >> "$LOG"
echo "[RUN] $(date)" >> "$LOG"
echo "[RUN] Starting ccminer" >> "$LOG"
echo "[RUN] Pool   : $POOL" >> "$LOG"
echo "[RUN] Wallet : $WALLET" >> "$LOG"
echo "[RUN] Threads: $THREADS" >> "$LOG"
echo "========================================" >> "$LOG"

exec "$BIN" \
  -a "$ALGO" \
  -o "$POOL" \
  -u "$WALLET" \
  -p "$PASS" \
  -t "$THREADS" \
  >> "$LOG" 2>&1
