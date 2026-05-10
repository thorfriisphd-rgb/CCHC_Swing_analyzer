#!/usr/bin/env bash
set -euo pipefail

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
RESULTS_DIR="results_${TIMESTAMP}"
SUMMARY_FILE="${RESULTS_DIR}/SWING_run_summary.txt"

mkdir -p "${RESULTS_DIR}"

echo "====================================="
echo "CCHC SWING Analyzer"
echo "====================================="

echo
echo "[1/2] Running SWING Lite analysis..."

python scripts/IBAM_SWING_script.py \
    --cassette data/MG_projected_trimmed_n26_core60_chem90.fa \
    --myht_dir data/MyhT_fastas \
    | tee "${RESULTS_DIR}/SWING_validation_results.txt"

echo
echo "Primary SWING results:"
echo "  ${RESULTS_DIR}"


echo
echo "[2/2] Running SWING controls..."

./run_controls.sh


SWING_RESULTS="${RESULTS_DIR}/SWING_validation_results.txt"

SWING_CONSERVED_LINE=$(grep "SWING-conserved positions" "${SWING_RESULTS}" || true)
INVARIANT_RECOVERED_LINE=$(grep "Invariant positions recovered" "${SWING_RESULTS}" || true)
TRP_LINES=$(grep "^  Pos .*W in .*INVARIANT" "${SWING_RESULTS}" || true)

CONTROL_DIR=$(ls -td controls_* | head -n 1)

WITHIN_RESULTS="${CONTROL_DIR}/results/within_sequence_shuffle_results.txt"
COLUMN_RESULTS="${CONTROL_DIR}/results/column_shuffle_results.txt"
RANDOM_RESULTS="${CONTROL_DIR}/results/random_window_results.txt"

WITHIN_SWING=$(grep "SWING-conserved positions" "${WITHIN_RESULTS}" || true)
WITHIN_INV=$(grep "Invariant positions recovered" "${WITHIN_RESULTS}" || true)

COLUMN_SWING=$(grep "SWING-conserved positions" "${COLUMN_RESULTS}" || true)
COLUMN_INV=$(grep "Invariant positions recovered" "${COLUMN_RESULTS}" || true)

RANDOM_SWING=$(grep "SWING-conserved positions" "${RANDOM_RESULTS}" || true)
RANDOM_INV=$(grep "Invariant positions recovered" "${RANDOM_RESULTS}" || true)


cat > "${SUMMARY_FILE}" << EOF
==================================================
CCHC SWING Analyzer — Run Summary
==================================================

Run timestamp:
  ${TIMESTAMP}

Primary results directory:
  ${RESULTS_DIR}

Control results directory:
  $(ls -td controls_* | head -n 1)

Main cassette:
  data/MG_projected_trimmed_n26_core60_chem90.fa

Key findings:
  ${SWING_CONSERVED_LINE}
  ${INVARIANT_RECOVERED_LINE}

Invariant tryptophan positions:
${TRP_LINES}

Control headline results:

Within-sequence shuffle:
  ${WITHIN_SWING}
  ${WITHIN_INV}

Column shuffle:
  ${COLUMN_SWING}
  ${COLUMN_INV}

Random IBAM windows:
  ${RANDOM_SWING}
  ${RANDOM_INV}

Controls generated:
  - Within-sequence shuffle
  - Column shuffle
  - Random IBAM windows

Pipeline status:
  COMPLETE

EOF

echo
echo "Run summary written to:"
echo "  ${SUMMARY_FILE}"



echo
echo "====================================="
echo "SWING pipeline complete."
echo "====================================="
