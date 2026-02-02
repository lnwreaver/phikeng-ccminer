#!/bin/bash
cd "$(dirname "$0")"

CMD="./ccminer -a $ALGO -o $POOL -u $WALLET.$WORKER -t $THREADS $EXTRA"​

echo "[RUN] $CMD"
exec $CMD
