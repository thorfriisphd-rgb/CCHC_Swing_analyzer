#!/usr/bin/env bash
set -euo pipefail

mkdir -p controls/results

echo "[1/4] Generating internal control FASTAs..."
python scripts/make_swing_controls.py

echo
echo "[2/4] Scoring within-sequence shuffle control..."
python scripts/IBAM_SWING_script.py \
    --cassette controls/01_within_sequence_shuffle/MG_n26_within_sequence_shuffled.fa \
    --myht_dir data/MyhT_fastas \
    | tee controls/results/within_sequence_shuffle_results.txt

echo
echo "[3/4] Scoring column shuffle control..."
python scripts/IBAM_SWING_script.py \
    --cassette controls/02_column_shuffle/MG_n26_column_shuffled.fa \
    --myht_dir data/MyhT_fastas \
    | tee controls/results/column_shuffle_results.txt

echo
echo "[4/4] Scoring random-window control..."
python scripts/IBAM_SWING_script.py \
    --cassette controls/03_random_IBAM_windows/C12_random_windows_n26.fa \
    --myht_dir data/MyhT_fastas \
    | tee controls/results/random_window_results.txt
