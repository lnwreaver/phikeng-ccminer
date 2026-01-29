# phikeng-ccminer

Centralized ccminer control system for Termux-based mining farms.

## Core Architecture
- `main.py` – central brain
- `config.json` – wallet / pool / threads
- `run.sh` – executor
- `ccminer` – local binary

## Usage (Termux)
```bash
cd ~/etc/mobile-mining
python main.py
