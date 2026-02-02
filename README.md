# phikeng-ccminer

Centralized ccminer control system for Termux-based mining farms.

## Core Architecture
- `main.py` – central brain
- `config.json` – wallet / pool / threads
- `run.sh` – executor
- `ccminer` – local binary

## Usage (Termux)
```bash
cd ~/etc/mobile-mining/phikeng-ccminer/core
python main.py
## Legacy (Knowledge / Archived)

The `legacy/` directory contains historical control scripts and configurations.
These files are preserved for reference and learning purposes only and are not
used by the current mining execution flow.

- begin-control.json
- cpu-control.json
- mining-control.json
- online.json
- solo.json
- set.json
- verus.json
- start
