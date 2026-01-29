#!/usr/bin/env python3
import json, os, subprocess, sys, time

BASE = os.path.dirname(os.path.abspath(__file__))
CONFIG = os.path.join(BASE, "config.json")
LOGDIR = os.path.join(BASE, "logs")
LOGFILE = os.path.join(LOGDIR, "miner.log")

def log(msg):
    os.makedirs(LOGDIR, exist_ok=True)
    line = f"[{time.strftime('%Y-%m-%d %H:%M:%S')}] {msg}"
    print(line)
    with open(LOGFILE, "a") as f:
        f.write(line + "\n")

def load_config():
    if not os.path.exists(CONFIG):
        log("❌ config.json not found")
        sys.exit(1)
    with open(CONFIG) as f:
        cfg = json.load(f)

    required = ["algo", "pool", "wallet"]
    for k in required:
        if k not in cfg or not cfg[k]:
            log(f"❌ missing config: {k}")
            sys.exit(1)
    return cfg

def already_running():
    try:
        out = subprocess.check_output(["pgrep", "-f", "ccminer"])
        return bool(out.strip())
    except:
        return False

def main():
    log("🧠 Brain started")
    cfg = load_config()

    if already_running():
        log("⚠️ ccminer already running, exit")
        return

    env = os.environ.copy()
    env["ALGO"] = cfg["algo"]
    env["POOL"] = cfg["pool"]
    env["WALLET"] = cfg["wallet"]
    env["WORKER"] = cfg.get("worker", "node")
    env["THREADS"] = str(cfg.get("threads", "auto"))
    env["EXTRA"] = cfg.get("extra", "")

    log("▶️ Starting miner")
    subprocess.Popen(["bash", "run.sh"], cwd=BASE, env=env)

if __name__ == "__main__":
    main()
