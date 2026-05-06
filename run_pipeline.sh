#!/usr/bin/env bash
set -euo pipefail

echo "====================================="
echo "CCHC SWING Analyzer"
echo "====================================="

CASSETTE="data/MG_projected_trimmed_n26_core60_chem90.fa"
MYHT_DIR="data/MyhT_fastas"

mkdir -p results controls/results

echo
echo "[1/2] Running SWING Lite analysis..."
python scripts/IBAM_SWING_script.py \
    --cassette "$CASSETTE" \
    --myht_dir "$MYHT_DIR" | tee results/SWING_validation_summary.txt

echo
echo "[2/2] Generating internal controls..."



    mkdir -p \
  controls/01_within_sequence_shuffle \
  controls/02_column_shuffle \
  controls/03_random_IBAM_windows \
  controls/logs \
  controls/results \
  results


python scripts/make_swing_controls.py



echo
echo "[3/5] Running within-sequence shuffle control..."

python scripts/IBAM_SWING_script.py \
    --cassette controls/01_within_sequence_shuffle/MG_n26_within_sequence_shuffled.fa \
    --myht_dir data/MyhT_fastas \
    | tee controls/results/within_sequence_shuffle_results.txt

echo
echo "[4/5] Running column shuffle control..."

python scripts/IBAM_SWING_script.py \
    --cassette controls/02_column_shuffle/MG_n26_column_shuffled.fa \
    --myht_dir data/MyhT_fastas \
    | tee controls/results/column_shuffle_results.txt

echo
echo "[5/5] Running random-window control..."

python scripts/IBAM_SWING_script.py \
    --cassette controls/03_random_IBAM_windows/C12_random_windows_n26.fa \
    --myht_dir data/MyhT_fastas \
    | tee controls/results/random_window_results.txt



echo
echo "Pipeline completed successfully."
