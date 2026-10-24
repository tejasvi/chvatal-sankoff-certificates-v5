# Second checker: programs, runs and logs

This directory holds the second checker. It was written independently of the first checker, from the definition of
the automaton M_h, and shares with it only the file formats: sorted little-endian uint64 keys
x<<3h | y<<2h | dx<<h | dy, and one little-endian float64 entry of v per key. The checker computes every transition
with its own code.

## Programs

- `mh_audit_delta.h`: the transition function q -> delta(q, T_{c,l}) of M_h. It is a plain dynamic-programming window
  (row 0 and column 0 extended by constants beyond h), followed by the canonical backtrack (up, else left, else
  diagonal, accepting at (h, h) with exactly one diagonal step) and the complement reduction. It aborts if an
  increment leaves {0, 1}.
- `mhcheck.cpp`: the exact check. It verifies that
  - the keys are strictly increasing, in range, and contain q0 = <0^h, 0^h, 1^h, 1^h>;
  - every accepted successor of every listed state is listed;
  - for every state q, sum_{c,l} W_|l| V(delta(q, T_{c,l})) <= LAM V(q). This is computed in unsigned 128-bit
    integers. V = v 2^K is exact, with K = 53 - e_min, where e_min is the least exponent e in v = m 2^e,
    1/2 <= m < 1; exactness is checked for every entry. A
    sufficient condition for no overflow, (Wsum + 1) max V < 2^128, is checked too.

  It prints the least LAM that passes every row and the number of rows that fail at LAM - 1. Optional in-pass negative
  tests are set by environment variables:
  - `MHC_W2`: a second weight list, for example for a wrong z;
  - `MHC_PERTURB` with `MHC_PERTURB_DIV`: one entry V(p) is replaced by V(p) - (V(p)/DIV + 1);
  - `MHC_MISSING`: a state is emulated as removed, and the successor lookups that land on it are counted;
  - `MHC_DROP`: one entry is really removed from keys and v in memory.

  These tests do not change the main check.
- `weights_bound.py`: `weights H Z` prints W_k = ceil(2^64 w_z(k)) for the exact decimal z, where
  w_z(k) = z^(k+2) for k < H-1 and z^(H+1)/(1-z) for k = H-1. `bound Z LAM` evaluates 2 ln(2z)/ln(LAM/2^64) in mpmath
  interval arithmetic at 200 bits and with python-flint arb, then rounds it up to 6 decimals with exact rationals.
- `mhbfs.cpp`: breadth-first search with Lueker's numbering. It prints state counts. In mode `stream` it writes the
  transition table in the layout of the file trans_h<h>.bin published by Jack (2026), for comparison by SHA-256.
- `mhbfs_hash.cpp`: breadth-first search of the reachable state set with a lock-free hash set. It writes the sorted
  keys file; used for h = 11 and h = 12.
- `negtools.cpp`: helpers for negative tests on large files: find a key, scale one entry of v in place (only on a
  copy), drop one entry.
- `neg_cs.py`: negative tests by file modification. It needs numpy.
- `mh_audit_ref.py`: a Python reference of the automaton. It provides Lueker's h = 2 table, the state counts, and
  random tests that the automaton accepts the truncated canonical decomposition of random string pairs.

Build: `g++ -O2 -fopenmp -o P P.cpp` for P = mhcheck, mhbfs, mhbfs_hash, and `g++ -O2 -o negtools
negtools.cpp`. The C++ programs do not use assert; they check explicitly. The Python programs that use assert refuse
to run under -O.

## Inputs (SHA-256)

| h | keys | v | z | LAM |
| --- | --- | --- | --- | --- |
| 8 | e3def50f04811580fa19b034d4b94771f61e71831ab5a4b3c3af0a33f495b0a3 | 121ccf4f8eff056abdc7964901b1a465dbc9efba8c8bfda9d0e3e9462f7653af | 0.3209 | 6305692192723871581 |
| 9 | ce295f3eb17e476ddf6ae3c0aff18f9fcb5ff587977baa4f8d416890c1a43fa4 | debdd3f25f3860c23ddda201e4caaaab1b31eea2e7eb8b30d6afac6b00325c54 | 0.3298 | 6727681800027252070 |
| 10 | 3addff1b337b284fe698772f1fc26a4ca191057b14a2b9650dafbf1bd8b4e53d | 4eb81b8716615ba6bf32193048da9eecdddf58cc98a5fdc9d741aec79e8cba10 | 0.3376 | 7111821154096593734 |
| 11 | 58c8ae21c93a2fd7c676a98eef53579092d90289275ff8e256b0cb947b35953c | a62dfee569f8b446ef0342c4d7bf072f0362f48ac175f0b05b5dd627654fd1ee | 0.3445 | 7462926034979082163 |
| 12 | bef385e5bdc772fdc198ad3fddb268e392105c06c30288025c50bbad42e258c5 | 915ac393b4952851e72938e4aea097c566039a43546b75a3a0fa8c760221c865 | 0.3505 | 7776813894375449830 |

## Logs (`logs/`)

| log | command | result |
| --- | --- | --- |
| `sources_at_h8-h10_run.txt` | `sha256sum *.cpp *.h *.py` in the run directory before the runs for h = 8, 9 and 10 | the source hashes at that time, equal to the files here; mhbfs_sort.cpp, also listed, was later left out because no log here uses it |
| `bfs_counts.out` | `python -I mh_audit_ref.py table2`; `./mhbfs h - 24` for h = 2..8 | Lueker's 7-state table for h = 2, numbering included; states 7, 98, 1020, 10160, 89960, 780368, 6419109 (Lueker's Table II) |
| `bfs_h9_tablehash.out`, `bfs_h10_tablehash.out` | `./mhbfs 9 stream 24 51425006 \| sha256sum`, same for h = 10 | d1ed951e... and 56679b28..., equal to the published SHA-256 of Jack's trans_h9.bin and trans_h10.bin |
| `check_h8.out`, `check_h9.out`, `check_h10.out` | `./mhcheck h KEYS V W LAM 24` with the in-pass negatives; then `weights_bound.py bound` | PASS; the least passing LAM equals LAM, and LAM - 1 fails one row; wrong z: every row fails; one entry of V halved: one row fails; one state removed: missing successors; bounds 0.826280, 0.825101, 0.824120 |
| `neg_h9.out` | `ARGMAX_IDX=4172473 python -I neg_cs.py 9 KEYS V 0.3298 LAM LAM 24` | all 8 modified certificates rejected: LAM - 1, z = 0.3299, v at the maximizing row times 1 - 1e-12, v(q0)/2, one entry doubled, one state removed, start state removed, a zero entry |
| `cover.out`, `coverruns.out` | `python -I mh_audit_ref.py cover H 300 400` and `coverruns H 200 400` | no rejection of a truncated canonical decomposition (uniform strings and strings with long runs) |
| `bfs_h11.out` | `./mhbfs_hash 11 33 KEYS 190` | 3,045,043,879 states, 53,133,194,463 accepted transitions; keys SHA-256 58c8ae21..., equal to the certificate's keys |
| `check_h11.out` | `./mhcheck 11 KEYS V W LAM 190` with the in-pass negatives; then `weights_bound.py bound` | PASS, least passing LAM = LAM, LAM - 1 fails one row; wrong z (0.3446): every row fails; v at the maximizing row reduced by V/10^12 + 1: one row fails; one state removed: 48 missing successors; bound 0.823290 |
| `drop_h11.out` | `MHC_DROP=i ./mhcheck 11 ...` for the start state and for one other state | both rejected: "start state missing"; 48 missing successors |
| `bfs_h12.out` | `./mhbfs_hash 12 36 KEYS 190` | 22,670,087,101 states, 418,139,991,128 accepted transitions; keys SHA-256 bef385e5... |
| `check_h12.out` | `./mhcheck 12 KEYS V W LAM 190` on the deterministic vector, with the in-pass negatives; then `weights_bound.py bound` | PASS, least passing LAM = LAM, LAM - 1 fails one row; wrong z (0.3506): every row fails; one entry of V halved: one row fails; one state removed: 4 missing successors; bound 0.82257836345 -> 0.822579 |
| `h12_first_vector/` | `./mhcheck 12 ...` on the first h = 12 vector (a279cb60..., LAM 7776814459376720853, not archived) and with the start state dropped | PASS, LAM tight, the same in-pass negatives rejected; start state dropped: rejected |

The checks for h = 8 to 11 and for the deterministic h = 12 vector, the breadth-first searches for h = 2 to 9 and 11,
and neg_h9.out were produced by exactly the files in this directory. bfs_h10_tablehash.out, bfs_h12.out,
h12_first_vector/, cover.out and coverruns.out come from earlier copies. In those copies the C++ programs had the same
object code (only comments differ, and no line was added or removed), and the Python program differed only in
docstrings and the -O guard.
