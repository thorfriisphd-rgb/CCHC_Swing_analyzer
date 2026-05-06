#!/usr/bin/env bash
set -euo pipefail

mkdir -p results

python scripts/IBAM_SWING_script.py \
    --cassette data/MG_projected_trimmed_n26_core60_chem90.fa \
    --myht_dir data/MyhT_fastas \
    | tee results/SWING_validation_summary.txt
