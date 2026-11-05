#!/usr/bin/env bash
# RTX 5060 8 GB starting profile. Keep k=8, H=32 and the original network widths;
# reduce parallel simulation/batch memory and disable compilation for initial runs.
# Arguments supplied by the caller override the defaults below.
set -euo pipefail
cd "$(dirname "$0")/.."
exec env -u PYTHONPATH -u PYTHONHOME PYTHONDONTWRITEBYTECODE=1 \
  .venv/bin/python -B -m supermimic.scripts.train \
  --run-name h1 --data.npz-dir data/npz/h1 \
  --env.num-envs 32 --env.replay-capacity 256 \
  --wm-trainer.batch-size 64 --wm-trainer.batches-per-update 1 \
  --policy-trainer.batch-size 32 \
  --wm-trainer.compile None --policy-trainer.compile None \
  "$@"
