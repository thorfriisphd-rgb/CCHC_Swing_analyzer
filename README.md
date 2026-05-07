
# CCHC-SWING-Analyzer
Current release: v0.1-alpha

---

## Conceptual framework

CCHC-SWING-analyzer operates downstream of the IBAM Grammar Engine (IGE).

The broader analytical framework proceeds as:

```text
Molecular dynamics trajectories
        ↓
PRCO contact decoding
        ↓
IGE evolutionary projection
        ↓
MG cassette derivation
        ↓
HARP register enrichment analysis
        ↓
SWING cassette-convergence analysis
        ↓
DALILite structural falsification
```

---

## Methodological origin

This repository implements a project-specific, lightweight adaptation inspired by Sliding Window Interaction Grammar (SWING), originally developed as an interaction language model for peptide/protein interaction prediction.

SWING represents protein interactions by sliding windows across paired sequences and encoding amino-acid property differences as an interaction vocabulary.

In this repository, the same broad conceptual principle is adapted to the IBAM/CCHC system: an IGE-derived major-groove cassette is compared against conserved MyhT sequence windows to test cassette-level interaction-grammar convergence.

This implementation is not a re-release of the original SWING model. It is a simplified, project-specific analytical adaptation for IBAM/C12–MyhT interaction-grammar testing.

### SWING citation

Siwek, J. C., Omelchenko, A. A., Chhibbar, P., et al. (2025).
*Sliding Window Interaction Grammar (SWING): a generalized interaction language model for peptide and protein interactions.*
Nature Methods.

---

## Repository structure

```text
CCHC_Swing_analyzer/
│
├── data/
│   ├── C12_aligned.fa
│   ├── MG_column_map_n26_core60_chem90.tsv
│   ├── MG_projected_trimmed_n26_core60_chem90.fa
│   └── MyhT_fastas/
│
├── scripts/
│   ├── IBAM_SWING_script.py
│   └── make_swing_controls.py
│
├── controls/
│   ├── 01_within_sequence_shuffle/
│   ├── 02_column_shuffle/
│   ├── 03_random_IBAM_windows/
│   ├── logs/
│   └── results/
│
├── results/
│
├── run_pipeline.sh
├── run_swing.sh
├── run_controls.sh
│
└── README.md
```

---

## Input files

### `C12_aligned.fa`

Source evolutionary alignment used to derive the MG-projected cassette representation employed by SWING Lite.

Included for provenance and reproducibility.

---

### `MG_column_map_n26_core60_chem90.tsv`

Mapping table linking projected MG positions to source alignment coordinates.

---

### `MG_projected_trimmed_n26_core60_chem90.fa`

Final MG-projected cassette used for SWING analysis.

Represents the conserved CCHC/IBAM interaction core after dual-gate filtering:

- occupancy threshold = 60%
- chemistry dominance threshold = 90%

---

### `MyhT_fastas/`

Myosin-tail FASTA windows spanning 26 taxa.

These represent the candidate interaction substrates evaluated against the conserved MG cassette.

---

## Installation

Tested on:

- Ubuntu Linux
- Python 3.10+

Install dependencies as required:

```bash
pip install numpy pandas biopython
```

---

## Running the pipeline

### Full reproducible run

From repository root:

```bash
./run_pipeline.sh
```

This will:

1. Run SWING Lite analysis
2. Generate internal null controls
3. Write outputs to the controls/results structure

---

### Run SWING only

```bash
./run_swing.sh
```

---

### Generate controls only

```bash
./run_controls.sh
```

---

## Internal controls

### Within-sequence shuffle

Randomizes residue order within sequences while preserving residue composition.

Tests whether convergence depends on positional organization rather than amino-acid frequency alone.

---

### Column shuffle

Randomizes projected cassette columns while approximately preserving column composition.

Disrupts:

- positional continuity
- inter-column covariance
- coordinated interaction grammar

while preserving marginal residue properties.

---

### Random IBAM windows

Samples random windows from IBAM/C12 alignments.

Tests whether convergence is specific to the MG cassette rather than a generic property of arbitrary windows.

---

## Position within the IBAM framework

CCHC-SWING-analyzer complements:

- **IBAM Grammar Engine (IGE)** — structure-guided evolutionary projection
- **HARP** — heptad/register enrichment analysis
- **IBAM-Stability-Quad** — MD stability and interface persistence analysis
- **IBAM-DALILite-benchmark** — structural falsification of the RNA ligase hypothesis

Together these repositories form a modular reproducibility ecosystem for evaluating the hypothesis that C12orf29/IBAM encodes a conserved actomyosin interaction component rather than a canonical RNA ligase.

---

## Reproducibility

This repository was designed to support transparent and reproducible analysis.

The scripts included are working analysis copies used directly during development of the IBAM project.

No external web services or proprietary software are required.

---

## Citation

If you use this repository, please cite:

> Friis, T. (2026).
> *C12orf29 encodes IBAM (In Between Actin and Myosin), a sarcomeric protein with a conserved actomyosin binding grammar spanning ~1 billion years of evolution.*
> bioRxiv [preprint pending].

---

## License

MIT License.

---

## Author

Thor Einar Friis

ORCID: https://orcid.org/0000-0002-4132-4912

Independent researcher, Bodø, Norway.
PhD in Molecular Biology, Queensland University of Technology (QUT).
