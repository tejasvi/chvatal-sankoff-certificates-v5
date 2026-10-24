# Certified upper bounds for the Chvátal–Sankoff constant

Certificates, programs and Lean formalization for the paper
*Certified upper bounds for the Chvátal–Sankoff constant* by Tejasvi Singh Tomar
(Zenodo, [doi:10.5281/zenodo.23610945](https://doi.org/10.5281/zenodo.23610945)).

## Result

Let `γ₂ = lim E LCS(A_n, B_n)/n`, where `A_n` and `B_n` are independent uniformly random binary strings of length `n`
(the Chvátal–Sankoff constant). The paper proves `γ₂ ≤ 0.821963`. The proof follows Lueker's method
(G. S. Lueker, J. ACM 56 (2009), Article 17): for a history length `h`, Lueker's automaton `M_h` reads a pair of strings
as a sequence of minimal match pairs, and a positive vector `v` with `A_z v ≤ λ v` for its weighted transition matrix
`A_z` gives `γ₂ ≤ 2 ln(2z)/ln λ` (Theorem 4.1 and Lemma 4.2 of the paper). The certificates:

| h | states (reduced) | accepted transitions | z | `Λ` (λ = Λ/2^64) | `2 ln(2z)/ln λ` | `γ₂ ≤` |
|---|---|---|---|---|---|---|
| 8 | 6,419,109 | 91,508,397 | 0.3209 | 6305692192723871581 | 0.8262791785… | 0.826280 |
| 9 | 51,425,006 | 790,078,170 | 0.3298 | 6727681800027252070 | 0.8251002729… | 0.825101 |
| 10 | 400,253,317 | 6,574,257,580 | 0.3376 | 7111821154096593734 | 0.8241195406… | 0.824120 |
| 11 | 3,045,043,879 | 53,133,194,463 | 0.3445 | 7462926034979082163 | 0.8232896731… | 0.823290 |
| 12 | 22,670,087,101 | 418,139,991,128 | 0.3505 | 7776813894375449830 | 0.8225783634… | 0.822579 |
| 13 | 165,695,219,469 | 3,217,333,414,315 | 0.3568 | 8116075413730513074 | 0.8219629194… | 0.821963 |

Each `z` is the exact decimal shown (for example `0.3505 = 701/2000`). The states are those of the automaton reduced by
the complement symmetry and reachable from the start state; the bound column is truncated, the last column rounded up.

## Files

| path | content |
|---|---|
| `src/check.cpp` | the checker: rebuilds every transition with its own code and verifies closure and `A_z v ≤ (Λ/2^64) v` in exact integer arithmetic |
| `src/check_v1.cpp` | the earlier version of the checker; it differs from `check.cpp` only in which cells of the window it resets between transitions |
| `src/cert_weights.py` | the weights `W_k = ⌈2^64 w_z(k)⌉`, computed from the exact rational `z` |
| `src/cert_bound.py` | the bound `2 ln(2z)/ln(Λ/2^64)` in interval arithmetic, rounded up to six decimals |
| `src/mh_ref.py` | a literal transcription of the automaton in Python, for small `h` |
| `src/mh_delta.h`, `src/mh_fast.h` | the direct and the bit-parallel transition functions of the search programs |
| `src/mh.cpp`, `src/mhbig.cpp`, `src/mhgroup.cpp`, `src/mhstream.cpp` | breadth-first search and power iteration (`mh` for `h ≤ 10`, `mhbig` for `h = 11`, `mhgroup` for the breadth-first search for `h = 12` and `h = 13`, `mhstream` for the power iteration for `h = 12`) |
| `src/mhstream_det.cpp` | the deterministic power iteration that produced the `h = 12` certificate (see below) |
| `src/mhiter.cpp` | the distributed deterministic power iteration that produced the `h = 13` vector (see below) |
| `src/check2.cpp`, `src/combine_check2.py` | the checker used for `h = 13`, a separate implementation of the checks of `check.cpp` that can split the rows over several runs, and the script that combines the outputs of such runs (see The certificate for h = 13) |
| `src/lorder.cpp` | writes the transition table in Lueker's order and in the file layout of L. Jack's repository, for the SHA-256 comparison |
| `src/validate_check.cpp`, `src/validate_fast.cpp` | compare the checker's transition function and the bit-parallel one with the direct one |
| `tools/pycheck.py` | recomputes the ratio `max_q (A_z v)_q / v_q` in exact rationals for small `h` |
| `tools/slack.py` | the largest `Λ` for which each bound still rounds to the same six decimals |
| `weights/` | the weight files for the six certificates |
| `logs/` | outputs of the checks, the bounds and the validation runs (see Logs) |
| `audit/` | a second checker, written independently, with its logs (see The second checker) |
| `lean/` | formal proofs in Lean 4 of the bounds for `h = 9, …, 13` (see Lean proofs) |

The certificates for `h = 8, 9, 10, 11` are in the Zenodo supplement,
[doi:10.5281/zenodo.23610946](https://doi.org/10.5281/zenodo.23610946). They are compressed losslessly with `zstd -10`,
and `zstd -d FILE.zst` decompresses a file:

| file | bytes | SHA-256 | compressed bytes | SHA-256 of the `.zst` file |
|---|---|---|---|---|
| `h8_keys.bin` | 51,352,872 | `e3def50f04811580fa19b034d4b94771f61e71831ab5a4b3c3af0a33f495b0a3` | 6,166,128 | `0fd36e185841b575e7f3d2e6bf602d894933f424e897d58d6e6a39609747530e` |
| `h8_v_0.320900.bin` | 51,352,872 | `121ccf4f8eff056abdc7964901b1a465dbc9efba8c8bfda9d0e3e9462f7653af` | 40,474,252 | `1a9a0053b33840a509038bb26c2db658e43261ce037c33488ff8d5b129717377` |
| `h9_keys.bin` | 411,400,048 | `ce295f3eb17e476ddf6ae3c0aff18f9fcb5ff587977baa4f8d416890c1a43fa4` | 48,872,584 | `db1d6431e2145d00db1f341359ff5056b40a29abb4af9999555b56a5054ed38d` |
| `h9_v_0.329800.bin` | 411,400,048 | `debdd3f25f3860c23ddda201e4caaaab1b31eea2e7eb8b30d6afac6b00325c54` | 336,871,584 | `cba4e46495ee8c4b75082f76881678974945ca06b194ed684674a14f40e108b3` |
| `h10_keys.bin` | 3,202,026,536 | `3addff1b337b284fe698772f1fc26a4ca191057b14a2b9650dafbf1bd8b4e53d` | 364,543,767 | `8607ed1fc1a85a61097911246bf47970d0cf5313f49fe2c81036aea6992fa193` |
| `h10_v_0.337600.bin` | 3,202,026,536 | `4eb81b8716615ba6bf32193048da9eecdddf58cc98a5fdc9d741aec79e8cba10` | 2,690,442,057 | `6e28a807818edcc5156de0bce4e819c84e2470d1ebb614df7efb4dd04941e74f` |
| `h11_keys.bin` | 24,360,351,032 | `58c8ae21c93a2fd7c676a98eef53579092d90289275ff8e256b0cb947b35953c` | 2,656,613,336 | `67758cef4e31b8656ddcd42504a246c06844c8debaacf016f7b226e7ce087a10` |
| `h11_v_0.344500.bin` | 24,360,351,032 | `a62dfee569f8b446ef0342c4d7bf072f0362f48ac175f0b05b5dd627654fd1ee` | 22,120,287,752 | `bd6706f19874a0e81d361910314bc083c21da88597cb2021619add4edf0117e7` |

In the Zenodo record, `h11_v_0.344500.bin.zst` is stored in 21 parts, `h11_v_0.344500.bin.zst.part000` to `part020`;
`cat h11_v_0.344500.bin.zst.part* > h11_v_0.344500.bin.zst` reassembles it, with the SHA-256 given in the table. The key
files are also reproduced exactly by the breadth-first search (`./mhgroup bfs H DIR`, see Search).

## Checking a certificate

The checker needs a C++ compiler with OpenMP and 128-bit integers (we used g++), and the two scripts need Python 3;
`cert_bound.py` also needs `mpmath`.

    g++ -O2 -fopenmp -o check src/check.cpp
    python3 src/cert_weights.py 11 0.3445 w.txt
    OMP_NUM_THREADS=32 ./check 11 h11_keys.bin h11_v_0.344500.bin w.txt
    python3 src/cert_bound.py 0.3445 7462926034979082163

`check` prints the number of states, the number of accepted transitions and `lam_num = Λ`, and exits with status 0 only
if the keys are strictly increasing, the start state is listed, every accepted successor of every listed state is
listed and every entry of `v` is a positive normal double. `cert_bound.py` prints the bound for that `Λ`. The keys are
sorted little-endian 64-bit state codes `x<<3h | y<<2h | dx<<h | dy` (oldest symbol in the most significant bit); `v` has
one little-endian double per state, in key order. The number of threads is set with `OMP_NUM_THREADS`. The weight files in
`weights/` are those that `cert_weights.py` writes.

Times of the logged runs: 3 s, 30 s and 341 s for `h = 8, 9, 10` with 24 threads, 1464 s for `h = 11` with
64 threads, and 2706 s for `h = 12` with 288 threads. The check holds about 28 bytes per state in memory (keys, `v`
and its exact decomposition): about 11 GB for `h = 10`, 85 GB for `h = 11` and 635 GB for `h = 12`. If a row sum
overflows, the checker reports `Λ = 2^64 − 1`, which gives no useful bound.

## The certificate for h = 12

The two files of the `h = 12` certificate have 181,360,696,808 bytes each and are not archived. The programs in `src/`
regenerate them; the vector comes from `mhstream_det`, which starts at the all-ones vector, runs a fixed number of
iterations, rounds every operation separately and adds in a fixed order, so that its output does not depend on the
processor or the number of threads when it is built without contraction of multiply-adds:

    g++ -O2 -fopenmp -mpopcnt -o mhgroup src/mhgroup.cpp
    g++ -O2 -fopenmp -mpopcnt -ffp-contract=off -o mhstream_det src/mhstream_det.cpp
    g++ -O2 -fopenmp -o check src/check.cpp
    MH_CAPLOG2=36 ./mhgroup bfs 12 DIR                 # DIR/h12_keys.bin
    ./mhstream_det 12 DIR 0.3505 240 0                 # DIR/h12_vdet_0.350500.bin (240 iterations, no early stop)
    python3 src/cert_weights.py 12 0.3505 w.txt
    ./check 12 DIR/h12_keys.bin DIR/h12_vdet_0.350500.bin w.txt
    python3 src/cert_bound.py 0.3505 LAM

Expected results: `h12_keys.bin` has SHA-256 `bef385e5bdc772fdc198ad3fddb268e392105c06c30288025c50bbad42e258c5`,
`h12_vdet_0.350500.bin` has SHA-256 `915ac393b4952851e72938e4aea097c566039a43546b75a3a0fa8c760221c865`, and `check`
reports `Λ = 7776813894375449830`. Any vector with `Λ ≤ 7776819092424481736` gives the same rounded bound (see
`tools/slack.py`).

On a machine with 288 virtual cores and 2.2 TB of memory (logs in `logs/h12_det/`), the breadth-first search took 6 min
(peak about 780 GB), and reading the keys and building the transition table took 6 min (peak about 1.3 TB). The 240
iterations took 66 min, about 11 s each plus 2–3 min for each 181 GB checkpoint written every 25 iterations, with about
1.6 TB resident. Writing the vector took 6 min, and the check took about 55 min, including 10 min of loading (about
635 GB).
The total was less than two and a half hours.

`MH_VINIT=FILE MH_START_IT=K` resumes from the checkpoint written after iteration `K`, with the same result. The fifth
argument of `mhstream_det` is the tolerance of `mhstream`, and `0` disables the early stop.

## The certificate for h = 13

The certificate for `h = 13` is not archived because of its size: the list of states has 1,325,561,755,752 bytes
(165,695,219,469 states) and the vector, in single precision, has 662,780,877,876 bytes. The list comes from the same
breadth-first search as for `h = 12`, and the vector comes from `mhiter`, a distributed version of the deterministic power
iteration. It starts from the `h = 12` vector of the previous section: each state for `h = 13` takes the value at the state
for `h = 12` obtained by deleting the oldest symbol of `x`, `y`, `dx` and `dy` and applying the complement reduction, or
the smallest entry of that vector if there is no such state. Each of `P` machines computes the rows of a contiguous block
of states, keeps a copy of the whole vector and exchanges its block with the others after every iteration. Row sums are
formed in double precision in a fixed order and normalized by the exact maximum, and the iterates are stored in single
precision; built without contraction of multiply-adds, the program is designed to give the same vector for every `P`,
every number of threads and every resume point. The check uses `check2`, which reads the vector in single precision
(`--f32`) and can check a range of rows in each run. The global checks (sorted keys, start state, positive entries) are
made on the whole input in every run, and `combine_check2.py` checks that the ranges cover all states and that all runs
read the same three files, by 64-bit fingerprints:

    g++ -O2 -fopenmp -mpopcnt -o mhgroup src/mhgroup.cpp
    g++ -O2 -fopenmp -mpopcnt -ffp-contract=off -o mhiter src/mhiter.cpp
    g++ -O2 -fopenmp -o check2 src/check2.cpp
    MH_CAPLOG2=38 ./mhgroup bfs 13 DIR                  # DIR/h13_keys.bin
    # on machine R = 0, ..., P-1, with the h = 12 certificate of the previous section in DIR:
    MH_LIFT_KEYS=DIR/h12_keys.bin MH_LIFT_V=DIR/h12_vdet_0.350500.bin \
      ./mhiter 13 DIR/h13_keys.bin 0.3568 100 OUT R P IP_0,...,IP_{P-1} PORT
    python3 src/cert_weights.py 13 0.3568 w.txt
    ./check2 13 DIR/h13_keys.bin OUT/h13_v_0.356800.r0.f32 w.txt THREADS --f32 --rows LO HI --segments 32
    python3 src/combine_check2.py CHECK2_OUTPUT_1 ... CHECK2_OUTPUT_K
    python3 src/cert_bound.py 0.3568 8116075413730513074

`mhiter` writes the whole vector, as `OUT/h13_v_0.356800.r<R>.f32`, on every machine at the end. The ranges `[LO, HI)` of
the runs of `check2` can be any partition of `[0, 165695219469)`; the logged runs used the four ranges in `logs/h13/`. The
run that produced the checked vector was started for 160 iterations and stopped after iteration 100, when each machine
had written its block as a checkpoint; the vector is the concatenation of the four blocks in the order of the machines
(`logs/h13/assemble_rank*.out`). By design, a run of `mhiter` with 100 iterations gives the same iterate; no second run
was made to confirm this.

Expected results: `h13_keys.bin` has SHA-256 `8454e843e50a773f4fedfbf9dfc7aaf49df071b9a8ed3e275758a94f27d19828`, and `check2` prints the fingerprint `keys_fp=9e2d85eb064d6fe5`
for it and 3,217,333,414,315 accepted transitions in all; the checked vector has SHA-256
`b5456a64bdcc3a21e77cef50b964764af4be55c50b42b04a417777682a870fcb` and fingerprint `v_fp=c534d0a11fa16f80`; the weights
give `w_fp=096a6ae0ce697486`; and the combined result is `Λ = 8116075413730513074`. Any vector for which `check2` reports
`Λ ≤ 8116076067129428569` gives the same rounded bound 0.821963 (see `tools/slack.py`).

No SHA-256 of the lists that were checked was recorded: each machine generated its own copy by the breadth-first
search. These four copies and the later regeneration agree on the fingerprint `9e2d85eb064d6fe5`, on the numbers of
states and accepted transitions and on the size, and the SHA-256 given above is that of the regenerated list.

The breadth-first search took 2.3 hours on a machine with 160 virtual cores and 3.8 TB of memory, with a hash table of
2.2 TB (`logs/h13/additional_check/bfs_h13.out`). The iteration ran on four such machines. On each of them, `mhiter`
read the list, lifted the start vector and built its part of the transition table (1.80 to 1.87 TB) in 42 to 51
minutes, and the 100 iterations then took 6.5 hours (`logs/h13/mhiter_rank*.err`). Each of the four runs of
`check2` took between 53 and 56 minutes on one of them, of which 14 to 17 minutes were spent loading the input; `check2`
holds the keys and the vector in memory, about 2 TB for `h = 13`.

`logs/h13/` holds the outputs of the four runs of `check2` that checked the certificate, one quarter of the rows each
(`check2_h13_rank*.out`, with the progress output in the `.err` files), the logs of the assembly of the vector on each
machine (`assemble_rank*.out`), the output of `combine_check2.py` on the four runs (`combine_check2.out`), the output of `cert_bound.py` (`bound_h13.out`) and the logs of `mhiter`
(`mhiter_rank*.err`). Only machine 0 prints the iterations; the interval of ratios `(A_z v)_q / v_q` printed at
iteration `k` is that of the iterate before the update, so the last line belongs to the 99th iterate.
`additional_check/` holds the outputs of the additional check described in the paper, which used these commands, with
the regenerated list as `KEYS`, the reassembled vector as `VEC` and `weights/w_h13_0.3568.txt` as `W`:

    MH_CAPLOG2=38 ./mhgroup bfs 13 DIR
    g++ -O2 -o rowcheck logs/h13/additional_check/rowcheck.cpp
    ./rowcheck 13 KEYS VEC W 98550835305 21940538818 75003679099 151802308529 --random 1000 20261021
    ./check2 13 KEYS VEC W --f32 --rows 82847567618 106148478532 --segments 18 --drop-cache

The four rows given to `rowcheck` are those at which the four runs of `check2` attain their largest values; the option
`--random 1000 20261021` asks for 1000 further rows chosen by a pseudo-random generator with seed 20261021. The
additional check used copies of `src/mhgroup.cpp`, `src/mh_fast.h`, `src/check2.cpp` and `weights/w_h13_0.3568.txt`
identical to those shipped here.

Although the header of `check2.cpp` calls it a "second independent exact checker", `check2` is not the second checker of
`audit/`. Before it was used for `h = 13`, its transition function was compared with that of `check.cpp` on all
1.72·10^10 pairs of a reachable state and an input for `h = 2, ..., 10` and on 2.56·10^9 pairs met in random walks for
`h = 11, ..., 15`, with no difference, and both programs report the same `Λ` for the certificates for `h = 8, 9, 10`.
The programs and the outputs of this comparison are in `logs/check2_validation/`: `run_validation.sh` ran all of it,
with the outputs in `val/` and an overview in `summary.txt`. The comparison of the transition functions is the part
"1. transitions" (`harness.cpp` for all reachable states, `walk.cpp` for the random walks). The further parts include a
comparison of the decoding of the entries of the vector, checks of the certificates for `h = 8, 9, 10` (whole, for
`h = 9` and `10` also in ranges of rows, and for `h = 9` also rounded to single precision) and negative tests with
altered certificates. `harness.cpp`, `walk.cpp` and `bench.cpp` include `src/check.cpp` and `src/check2.cpp`; from the
top directory, build them with, for example,

    g++ -O3 -fopenmp -I src -o harness logs/check2_validation/harness.cpp

The script expects the lists for `h = 2, ..., 10` and the certificates for `h = 8, 9, 10` with their weights in
`../data`, and writes into `logs/val/`.

## Validation of the automaton

- For `h = 2` the programs reproduce the 7-state transition table printed in Lueker's overview of his programs
  (https://www.ics.uci.edu/~lueker/papers/lcs/code/).
- The numbers of reduced states for `h = 2, …, 8` are those of Lueker's Table II: 7, 98, 1020, 10160, 89960, 780368,
  6419109; for `h = 9` and `h = 10` they are 51,425,006 and 400,253,317, as in L. Jack's repository
  (https://github.com/leandrejack-afk/chvatal-sankoff-bound, commit 472c18de).
- `lorder` writes the `h = 9` and `h = 10` tables in the layout of L. Jack's repository; their SHA-256 values
  (`logs/validation/lorder_h9.sha`, `lorder_h10.sha`) equal the published ones for `trans_h9.bin` and `trans_h10.bin`.
- `validate_check` and `validate_fast` compare the checker's transition function and the bit-parallel one with the
  direct one on every input at every reachable state; neither finds a mismatch for `h = 2, …, 10` (`logs/validation/`).

## The second checker

`audit/` contains a second checker, written from the definitions in the paper and in Lueker's description of his
programs, independently of the programs in `src/`. It regenerates the state sets by its own breadth-first search and
checks the certificates for `h = 8, ..., 12` with its own transition function; it was not run for `h = 13`, where
`check2` and the Lean check (see Lean proofs) are the only programs that checked every row. `audit/RUNS.md` lists its
runs on these five certificates and their inputs.

| path | content |
|---|---|
| `audit/mhcheck.cpp`, `audit/mh_audit_delta.h` | the checker and its transition function: start state, closure and `A_z v ≤ (Λ/2^64) v` in exact integer arithmetic; it also reports the smallest `Λ` that passes |
| `audit/weights_bound.py` | the weights `⌈2^64 w_z(k)⌉` from the exact rational `z`, and the bound in interval arithmetic (with `mpmath` and `python-flint`) |
| `audit/mhbfs.cpp`, `audit/mhbfs_hash.cpp` | breadth-first search with the same transition function; `mhbfs` writes the transition table in the layout of L. Jack's repository, `mhbfs_hash` writes the sorted key file for large `h` |
| `audit/mh_audit_ref.py` | the automaton in Python, for small `h` |
| `audit/negtools.cpp`, `audit/neg_cs.py` | negative tests on modified copies of a certificate |
| `audit/logs/` | the logs of the runs |

    g++ -O2 -fopenmp -o mhcheck audit/mhcheck.cpp
    W=$(python3 audit/weights_bound.py weights 11 0.3445)
    ./mhcheck 11 h11_keys.bin h11_v_0.344500.bin $W 7462926034979082163 32
    python3 audit/weights_bound.py bound 0.3445 7462926034979082163

The last argument of `mhcheck` is the number of threads. Three environment variables add negative tests to the same
pass: `MHC_W2` gives a second list of weights, for example for a larger `z`; `MHC_PERTURB` gives the index of an entry
of `v` to decrease; `MHC_MISSING` gives the index of a state to treat as removed. `MHC_DROP` removes a state before the check.

## Logs

- `logs/check_h*.out`: the checks of the certificates for `h = 8, ..., 12`, all with `check.cpp`. `logs/RUNS.md` lists the inputs of
  each run with their SHA-256 values.
- `logs/h12_det/`: the outputs of the breadth-first search and of `mhstream_det` for `h = 12`, and the SHA-256 values
  of the two files.
- `logs/earlier_runs/`: earlier checks of the `h = 9`, `h = 10` and `h = 11` certificates, some of them with
  `check_v1.cpp`, all with the same `Λ`, and the check of a first `h = 12` certificate. That certificate is not
  archived; its `Λ = 7776814459376720853` gives the same rounded bound (see `logs/RUNS.md`).
- `logs/h13/`: the four runs of `check2` that checked the certificate for `h = 13`, the assembly of the vector, the output
  of `combine_check2.py`, `cert_bound.py` for this certificate (`bound_h13.out`), and in `additional_check/` the outputs of
  the additional check described in the paper: the regeneration of the list by the breadth-first search
  (`bfs_h13.out`), the SHA-256 of the reassembled vector, the rerun of `check2` on the rows from 82,847,567,618 to
  106,148,478,532, and the program that evaluated single rows (`rowcheck.cpp`, which uses the transition function of
  `check.cpp` with its own lookup and exact arithmetic) with its output. `logs/h13/mhiter_rank*.err` are the logs of the
  iteration that produced the vector.
- `logs/check2_validation/`: the comparison of `check2` with `check.cpp` (see the section on `h = 13`).
- `logs/bounds.out`: `cert_bound.py` for the certificates for `h = 8, ..., 12`.
- `logs/validation/`: the SHA-256 comparison with L. Jack's tables and the transition-function comparisons.

## Search

The search programs are not needed to check a certificate. They produce the state set by breadth-first search from
the start state and the vector `v` by power iteration in double precision (for `h = 13` the row sums are formed in
double precision and the iterates are stored in single precision); any positive vector that passes the check is a
valid certificate.

    g++ -O3 -march=native -fopenmp -o mhgroup src/mhgroup.cpp       # likewise mh, mhbig, mhstream
    ./mhgroup bfs H DIR                                           # state set DIR/h<H>_keys.bin
    ./mh build H DIR; ./mh eigen H DIR Z ITERS TOL [VINIT]           # h <= 10
    ./mhbig H DIR ZLIST ITERS TOL [PREV_KEYS PREV_V]                 # h = 11
    ./mhstream H DIR ZLIST ITERS TOL [PREV_KEYS PREV_V]              # h = 12

## Lean proofs (`lean/`)

`lean/` is a Lean 4 project with Mathlib (Lean v4.35.0-rc3 and Mathlib at the same tag; see `lean/lean-toolchain` and
`lean/lake-manifest.json`). It proves the bounds for h = 12 and h = 13, with computations evaluated by compiled code, and
the bounds for h = 9, 10, 11 and 12, with proofs checked entirely by the Lean kernel. The constant is defined in
`CS31a/Defs.lean`:

    noncomputable def lcsLen (A B : List Bool) : ℕ :=
      sSup {k : ℕ | ∃ s : List Bool, List.Sublist s A ∧ List.Sublist s B ∧ s.length = k}
    noncomputable def expLCS (n : ℕ) : ℝ :=
      (∑ A : Fin n → Bool, ∑ B : Fin n → Bool, (lcsLen (List.ofFn A) (List.ofFn B) : ℝ)) / 4 ^ n
    noncomputable def gamma2 : ℝ := limUnder atTop fun n : ℕ => expLCS n / n

and `tendsto_expLCS_div` (`CS31a/Fekete.lean`) proves that `expLCS n / n` converges to `gamma2`. These are the only
definitions in the statements of the six theorems. `CS31a/` also defines Lueker's automaton as in Section 3 of the paper
and proves Theorem 4.1 with Lemma 4.2 in a form without logarithms (`CS31a.gamma2_le_of_cw_cover`, `CS31a/Count.lean`).
`LuekerCriterion h` (`CS31a/Defs.lean`) and the covering statement `CoverExists h` are proved for every h by
`luekerCriterion` and `coverExists` (`CS31a/CoverExists.lean`). The checking programs and their soundness proofs are in
`CS31aCert/` and `CS31a/`; their packed transition functions are proved to agree with the definition of the automaton.
The six theorems:

| theorem | statement | `#print axioms` |
|---|---|---|
| `CS31aData.gamma2_le_n13` (`CS31aData/MainN13.lean`) | `gamma2 ≤ 0.821963` | `propext`, `Classical.choice`, `Quot.sound` and `CS31aData.N13.cert<j>._native.native_decide.ax_1_1` for j = 0, …, 55 |
| `CS31aData.gamma2_le_h12` (`CS31aData/MainH12.lean`) | `gamma2 ≤ 0.822579` | `propext`, `Classical.choice`, `Quot.sound` and `CS31aData.H12.cert<j>._native.native_decide.ax_1_1` for j = 0, …, 6 |
| `CS31aK.H9.gamma2_le` (`CS31aK/H9.lean`, generated) | `gamma2 ≤ 0.825101` | `propext`, `Classical.choice`, `Quot.sound` |
| `CS31aK.H10.gamma2_le` (`CS31aK/H10.lean`, generated) | `gamma2 ≤ 0.824120` | `propext`, `Classical.choice`, `Quot.sound` |
| `CS31aK.H11.gamma2_le` (`CS31aK/H11.lean`, generated) | `gamma2 ≤ 0.823290` | `propext`, `Classical.choice`, `Quot.sound` |
| `CS31aK.H12.gamma2_le` (`CS31aK/H12.lean`, generated) | `gamma2 ≤ 0.822579` | `propext`, `Classical.choice`, `Quot.sound` |

Each `…native_decide.ax_1_1` axiom asserts that the compiled evaluation of one check returned true. `AxiomsN13.lean`,
`AxiomsN12.lean`, `AxiomsK9.lean`, `AxiomsK10.lean`, `AxiomsK11.lean` and `AxiomsK12.lean` print the statements and
axioms. Run the commands below in
`lean/`, after `lake exe cache get`, which downloads the compiled Mathlib. Apart from the comment edits listed in the
section Notes on the archived files, the Lean files are those that were built and checked, so a few of their comments still
describe earlier stages of the development, and `lakefile.toml` declares executables whose sources are not included.

### h = 12 (compiled code)

The h = 12 certificate is not archived (see "The certificate for h = 12"). After regenerating its two files, split them
into the pieces that the data modules read (about 362 GB on each machine that checks a share, and a similar amount for
the compiled data modules):

    mkdir -p cert_data/h12
    split -b 400253320 -d -a 3 h12_keys.bin cert_data/h12/h12_keys.bin.part
    split -b 400253320 -d -a 3 h12_vdet_0.350500.bin cert_data/h12/h12_vdet_0.350500.bin.part

(pieces 000 to 453, the last of 45,942,848 bytes). The check is split by rows into seven shares, the modules
`CS31aData/H12/C0.lean`, …, `C6.lean`, each with one `native_decide`; `native_decide` runs compiled code, so the trusted
base of this theorem includes the Lean compiler. For each share j = 0, …, 6, on a machine with at least 900 GB of memory
and the pieces in `cert_data/h12`:

    lake build CS31aCert.Bytes:dynlib CS31aCert.Step:dynlib CS31aCert.Row:dynlib CS31aCert.KTree:dynlib \
      CS31aCert.Check:dynlib CS31aCert.KStep:dynlib CS31aCert.Check2:dynlib CS31aData.Elab

then compile, with `lean --load-dynlib=…` for the seven `CS31aCert` libraries in `.lake/build/lib/lean`, with
`LEAN_PATH` from `lake env printenv LEAN_PATH` and with `-o` and `-i` writing the `.olean` and `.ilean` files under
`.lake/build/lib/lean`, the 908 part modules `CS31aData/H12/K*.lean` and `CS31aData/H12/V*.lean` (in parallel), then
`CS31aData/H12.lean`, then `CS31aData/H12/C<j>.lean`. On one of these machines, after copying the other six
`CS31aData/H12/C<j>.olean` into its `.lake/build/lib/lean/CS31aData/H12/`:

    lake build CS31a.Assemble CS31a.CheckNative2 CS31a.Count CS31a.CoverExists
    lake env lean CS31aData/MainH12.lean -o .lake/build/lib/lean/CS31aData/MainH12.olean
    lake env lean AxiomsN12.lean

In our runs one share took 1 h 37 min on a machine with 192 virtual CPUs and 1.4 TB of memory, and each of the others
took 2 h 06 min to 2 h 14 min on machines with 224 virtual CPUs and 896 GB, with peaks of 855 to 870 GB of memory. The
part modules took about 4 minutes per machine, and `MainH12` took 85 s and needed 30 GB. `tools_gen_h12.py` writes `CS31aData/H12.lean`,
the part and share modules and `CS31aData/MainH12.lean` (arguments `247,220,220,220,220,220,220
384,448,448,448,448,448,448`); its output equals the shipped files byte for byte.

### h = 13 (compiled code)

The h = 13 certificate is not archived either (see "The certificate for h = 13"). Its check reads the certificate in a
compact form, which `tools_compact13.cpp` writes from the list `h13_keys.bin` and the vector, here called `h13_v.f32`
(SHA-256 `b5456a64…`), after checking that the keys are strictly increasing: the 20 least significant bits of each
state code (3 bytes per state, 497 GB); a table of 2^32 + 1 entries of 5 bytes (21.5 GB), in which entry `b` is the
index of the first state whose 32 most significant bits are at least `b`, and the last entry is the number of states;
and the single-precision vector itself (663 GB). Cut into pieces of whole chunks of 2^22 entries, these are 1,275, 54
and 1,718 pieces, one part module each:

    g++ -O2 -o compact13 tools_compact13.cpp
    mkdir -p cert_data/n13
    ./compact13 h13_keys.bin h13_v.f32 20 3 4294967296 5 cert_data/n13/h13c --no-vec
    ln h13_v.f32 cert_data/n13/h13c.vec
    cd cert_data/n13
    split -b 390070272 -d -a 4 h13c.low h13c.low.part     # 1,275 pieces
    split -b 398458880 -d -a 4 h13c.tab h13c.tab.part     # 54 pieces
    split -b 385875968 -d -a 4 h13c.vec h13c.vec.part     # 1,718 pieces
    cd ../..

In this build only `compact13` reads `h13_keys.bin`; deleting it before the split keeps the disk needed at about 2.5 TB
(otherwise about 3.7 TB). `compact13` prints the SHA-256 of the files it writes; `gen/n13_files.sha256` gives those of
the input files, of `tools_compact13.cpp` and of the three compact files (and of our `compact13` binary, which depends
on the compiler), and `gen/n13_parts.sha256` those of the pieces. The shares fix `Λ = 8116075413730513074`, so a rebuild
needs a vector that passes the check with this `Λ`; the vector that we checked, with SHA-256 `b5456a64…`, is one (see
"The certificate for h = 13").

The check is split by rows into 56 shares, the modules `CS31aData/N13/C0.lean`, …, `C55.lean`, each with one
`native_decide`. Each share decodes the three arrays, checks that the table is nondecreasing and the global conditions
(`h ≥ 2`, one weight for each input length, the start state is listed), and checks its range of rows.
`CS31aCert/Check13.lean` is the checking program for this layout. `CS31a.checkCert13R_soundR`
(`CS31a/CheckNative13.lean`) proves that shares whose row ranges cover all states give the hypotheses of
`CS31a.sound_of_rows` (`CS31a/CheckSound.lean`), as the shares for h = 12 do. Every index that a search in the table
or in the low bits returns is checked against the data, and the table is checked to be nondecreasing, so the proof uses
no property of the searches. Nor does it depend on the conversion of the single-precision entries, because the vector
of the theorem is the converted one, or on `tools_compact13.cpp`, because the states and the vector of the theorem are
those that the compact files define. `tools_gen_n13.py gen/n13.json` writes `CS31aData/N13.lean`, the 3,047 part
modules `CS31aData/N13/L*.lean`, `T*.lean` and `V*.lean`, the 56 share modules and `CS31aData/MainN13.lean`; its output
equals the shipped files byte for byte (`generated_N13_SHA256SUMS`). With the pieces in `cert_data/n13`:

    ./tools_build_native.sh N13
    lake env lean AxiomsN13.lean

`tools_build_native.sh` builds the library and the eight `CS31aCert` libraries with Lake, then compiles the part
modules, `CS31aData/N13.lean`, the shares (each with as many threads as the machine has virtual CPUs) and
`CS31aData/MainN13.lean` directly with `lean --load-dynlib=…`, as for h = 12, and prints the axioms. On one machine like
ours (360 virtual CPUs, 2,880 GiB) it needs, by our timings, about two days for the part modules, which it compiles one
after another (our run compiled them 360 at a time), and about three and a half days for the 56 shares. A share needs
about 2,350 GiB of memory, since it decodes the whole compact certificate and maps the compiled part modules (about 1.2
TB). The shares are independent: they can run on separate machines, each with the part modules and `CS31aData/N13.lean`
built locally, and the 56 files `CS31aData/N13/C<j>.olean` are then copied to one machine for `MainN13`. The script was
tested on a small certificate (h = 4); for h = 13 our run spread the same commands over 22 machines. The compaction
needs about 2.5 TB of disk for the list, the vector and the two compact files written from them. Once the list and the
unsplit files are deleted, the pieces (1,181,341,372,768 bytes), the compiled part modules (about 1.2 TB) and Lean with
Mathlib (about 12 GB) take about 2.4 TB.

In our run the 56 shares ran on 22 machines with 360 virtual CPUs and 2,880 GiB of memory each. A share took 1 h 25 min
to 1 h 40 min (5,070 to 5,970 s; 23,802 CPU-hours for all 56), with peaks of 2,334 to 2,352 GiB of memory. The part
modules took about 8 minutes per machine, `CS31aData/N13.lean` 9 s and 30.6 GiB, and `MainN13` 30 s and 84.4 GiB.

An independent check rebuilt the 3,047 part modules and `CS31aData/N13.lean` from the pieces, compiled two shares, drawn
at random before any result was known, and `CS31aData/MainN13.lean` again, and obtained compiled files identical byte
for byte to ours; its own `#print axioms` shows the axioms above. `leanchecker`, run on each of the 3,138 modules of the
proof, accepted 3,137 of them (all part modules, the 56 shares, `MainN13` and the library), with the compiled checks
entering as their auxiliary axioms. On `CS31aData/N13.lean`, which holds four definitions, it ran out of memory on a
machine like ours (360 virtual CPUs, 2,880 GiB); the compiled file of that module is identical to one compiled
independently, during which the kernel checked these definitions.

### h = 9

The proof of `CS31aK.H9.gamma2_le` checks the published h = 9 certificate with the Lean kernel (`decide +kernel`), in
524,288 shards: 16 per module, in 32,768 modules, combined in 512 group modules and a top module. Compiled code is used
only to read the certificate files into Lean terms while the modules are compiled. These generated modules are not
shipped; `tools_gen_k4.py` writes them (`CS31aK/H9.lean` and `CS31aK/H9/`), and `generated_K9_SHA256SUMS` lists their
SHA-256 checksums. Decompress the h = 9 files of the supplement record into `cert_data/` (`h9_keys.bin` and
`h9_v_0.329800.bin`, uncompressed SHA-256 `ce295f3e…` and `debdd3f2…`), then run

    python3 tools_gen_k4.py 9 cert_data/h9_keys.bin cert_data/h9_v_0.329800.bin 51425006 32 9 10 16 \
      6727681800027252070 1649 5000 1637 1984 0.825101 \
      2006416197279003459,661716061862615341,218233957202290540,71973559085315420,23736879786337026,7828422953533952,2581813890075498,851482220946899,419007514873601
    sha256sum -c generated_K9_SHA256SUMS
    ./build_k4.sh 90 96
    lake env lean AxiomsK9.lean

`build_k4.sh P MEMGB` builds the library, then compiles the data module, the shard modules (P at a time, each under a
memory cap of MEMGB GiB), the groups (P at a time) and the top. A shard module needs about 4 GB and a group about 8 GB,
so the groups need about 8·P GB of memory (we ran them with P = 64 on a machine with 732 GB). In our run the shard
modules took about 210 s each under load, about 1,900 CPU-hours in all, spread over ten machines with 96 to 128 virtual
CPUs; on one machine the shard phase takes about 1,900/P hours. The groups took about 90 s each, and the top module took
21 s.

### h = 10

The proof of `CS31aK.H10.gamma2_le` checks the published h = 10 certificate in the same way and with the same library,
in 4,194,304 shards: 32 per module, in 131,072 modules, combined in 2,048 group modules and a top module. As for h = 9,
the generated modules are not shipped: `tools_gen_k5.py` writes them (`CS31aK/H10.lean` and `CS31aK/H10/`, after
deleting an existing `CS31aK/H10/`), and `generated_K10_SHA256SUMS` lists their SHA-256 checksums. Decompress the
h = 10 files of the supplement record into `cert_data/` (`h10_keys.bin` and `h10_v_0.337600.bin`), then run

    python3 tools_gen_k5.py 10 cert_data/h10_keys.bin cert_data/h10_v_0.337600.bin 400253317 32 11 11 32 \
      7111821154096593734 211 625 4025 4884 0.824120 \
      2102444781838394746,709785358348642067,239623536978501562,80896906083942128,27310795493938863,9220124558753760,3112714051035270,1050852263629507,354767724201322,180811569580867
    sha256sum -c generated_K10_SHA256SUMS
    ./build_k10.sh 90 96
    lake env lean AxiomsK10.lean

`build_k10.sh P MEMGB` runs the same steps as `build_k4.sh`. It repeats on one machine the steps that our build spread
over many machines, and it was not run end to end on one machine.

The data module needs 46.8 GiB of memory and took 33 minutes. A shard module needs at most 3.92 GiB and a group about
7.7 GiB. The script uses one P for both steps: with P = 90 the shard step needs about 360 GiB and the group step about
690 GiB, so on a smaller machine use a smaller P. Besides Lean and Mathlib (about 12 GB), the build needs about 36 GB of
disk, most of it for the compiled modules (about 26 GB) and the certificate files (6.4 GB). In our run the shard modules
took about 21,100 CPU-hours in all, on 113 machines with 32 to 160 virtual CPUs. On the machines with 60 virtual CPUs,
all of them busy, a shard module took 536 s at the median. The groups took 194 s at the median; the top module took 160
s and needed 17.3 GiB.

### h = 11

The proof of `CS31aK.H11.gamma2_le` uses a lane-packed version of the checking program, `CS31aCert/KLane.lean`. It
processes up to 64 consecutive states of the list together: for each input, each state occupies its own 64-bit field
(lane) of one natural number, and the bit operations of the transition function act on all lanes at once.
`CS31a.checkKL_sound_all` (`CS31a/KLaneSound.lean`) proves for this version what the other soundness proofs prove for
the checking program: if it accepts a list, the list is closed under the reduced transitions, every entry of the vector
is positive and the inequality holds at every listed state. The top module checks separately that the start state is
listed.

The certificate is checked in 2^23 parts of about 363 states. Each of the 65,536 shard modules proves one theorem with
the tactic `kl_split 7`, which splits its range of the list into 128 subranges and checks each by `decide +kernel`.
2,048 group modules and a top module combine these theorems with `CS31a.checkKL_splitC` (`CS31a/KLSplit.lean`, which
also defines `kl_split`); this lemma has the statement of `CS31a.checkKL_split` (`CS31a/KLaneTree.lean`), with a proof
in core Lean. The list and the vector are read in 64 pieces, one data module for each piece.

The generated modules are not shipped either: `tools_gen_kl.py` writes them (`CS31aK/H11.lean` and `CS31aK/H11/`, after
deleting an existing `CS31aK/H11/`), and `generated_K11_SHA256SUMS` lists their SHA-256 checksums. `gen/` contains the
arguments of the generator (`A11S.txt`), the first state of each piece (`firstkeys_h11.tsv`) and suffixes for the names
of three data modules (`dnames_h11.txt`), chosen so that the addresses at which Lean maps their compiled files do not
collide. Decompress the h = 11 files of the supplement record into `cert_data/` (`h11_keys.bin` and
`h11_v_0.344500.bin`), then run

    MODE=split DNAMES=gen/dnames_h11.txt FIRSTKEYS=gen/firstkeys_h11.tsv python3 tools_gen_kl.py $(cat gen/A11S.txt)
    sha256sum -c generated_K11_SHA256SUMS
    ./build_k11.sh 90 128
    lake env lean AxiomsK11.lean

`build_k11.sh P MEMGB` cuts the list and the vector into the 64 pieces (`tools_split_parts.py`), then compiles the data
modules, the shard modules (P at a time, each under a cap of MEMGB GiB of virtual memory), the groups and the top. Like
`build_k10.sh`, it was not run end to end on one machine.

The data modules took about 86 s each and need up to 4.7 GiB. The shard modules map the compiled data modules, 59.9 GiB,
which the processes share, and each needs at most 3.1 GiB more; the cap counts the mapped files, so MEMGB must be above
about 96, and with P = 90 the shard modules need about 340 GiB of memory. In our run the shard modules took about 8,800
CPU-hours in all, on 108 machines with 32 or 60 virtual CPUs; on the machines with 60 virtual CPUs a shard module took
483 s at the median. The groups took about 1 s each; the top module took 49 s and needed 26.2 GiB. Besides Lean and
Mathlib, the build needs about 170 GB of disk: 49 GB for the certificate files, as much again for the 64 pieces and
about 73 GB for the compiled modules. Only the cutting step reads the certificate files; if they are deleted after it,
about 120 GB suffice.

### h = 12 (kernel only)

The proof of `CS31aK.H12.gamma2_le` checks the h = 12 certificate of "The certificate for h = 12" with the lane-packed
program of h = 11, in the same way: in 2^26 parts of about 338 states, with 524,288 shard modules, each proving one
theorem with `kl_split 7`, 8,192 group modules and a top module. The list and the vector are read in 256 pieces, one
data module for each piece. The generated modules are not shipped: `tools_gen_kl.py` writes them (`CS31aK/H12.lean`
and `CS31aK/H12/`, after deleting an existing `CS31aK/H12/`), and `generated_K12_SHA256SUMS` lists their SHA-256
checksums. `gen/A12S.txt`, `gen/firstkeys_h12.tsv` and `gen/dnames_h12.txt` play the roles of the h = 11 files. After
regenerating the two files of the certificate into `cert_data/` (`h12_keys.bin` and `h12_vdet_0.350500.bin`), run

    MODE=split DNAMES=gen/dnames_h12.txt FIRSTKEYS=gen/firstkeys_h12.tsv python3 tools_gen_kl.py $(cat gen/A12S.txt)
    sha256sum -c generated_K12_SHA256SUMS
    ./build_k12.sh 90 1024
    lake env lean AxiomsK12.lean

`build_k12.sh P MEMGB` differs from `build_k11.sh` only in the names of h = 12, the 256 pieces and its comments. It
repeats on one machine the commands that our build ran on many machines; the script itself was not run.

The data modules took about 160 s each and need up to 7.4 GiB; `Data` took 13 s and 26.0 GiB. The shard modules map the
256 compiled data modules, 446.0 GiB, which the processes share, and each needs at most 5.6 GiB more. The cap counts the
mapped files, so MEMGB, which is in GiB, must be well above 446 (our build used 1024; a cap of 96 failed). The machine
needs about 450 GiB for the shared pages plus 2 to 6 GiB for each shard module running in parallel: with P = 90, between
about 630 and 950 GiB. In our run the shard modules took about 69,000 CPU-hours. Of these, 59,513 CPU-hours were
measured, for 446,464 modules: 38,558 on machines with 360 virtual CPUs and 1,440 GiB, 3,054 on machines with 128
virtual CPUs and 1,952 GiB, and 17,901 on machines with 64 to 160 virtual CPUs. The timing logs of the other 77,824
modules were lost with the three machines that built them (their compiled files were kept); at the median time of their
machine type, 449 s, they add about 9,700 CPU-hours. On the machines with 360 virtual CPUs, all of them busy, a shard
module took 449 s at the median. The 8,192 groups took 2.4 s each on average (at most 17 s) and needed at most 3.3 GiB;
the top module took 884 s and needed 194.9 GiB. An independent rebuild of the top module with the settings of
`build_k12.sh`, which writes `.ilean` files and caps the address space, took 7,057 s, against 697 s with the command of
our run; both gave the same compiled file. The build needs about 1.29 TB of disk, including Lean and Mathlib (about 12
GB): 363 GB for the certificate files, as much again for the 256 pieces and about 547 GB for the compiled modules, 479
GB of them for the data modules. Only the cutting step reads the certificate files; if they are deleted after it, about
0.93 TB suffice.

## Notes on the archived files

- The header of `check.cpp` mentions an optional `THREADS` argument, which is not used, and the usage line in the header
  of `mhstream_det.cpp` omits the fifth argument.
- The header of `check2.cpp` and `logs/check2_validation/run_validation.sh` refer to a working file that is not part of
  this archive. The specification of `check2.cpp` is that of `check.cpp` and of Sections 3 and 4 of the paper.
- The header of `logs/h13/additional_check/rowcheck.cpp` and `logs/check2_validation/summary.txt` give the SHA-256 of
  `check.cpp` as `3704d6e5...`, that of the file before a comment in its second line was reworded; the code is the same.
- In `run_validation.sh` the two lines naming the working directory read `WORKDIR`, and in `summary.txt` the line with
  the compiler gives only its version.
- `logs/h13/combine_check2.out` refers to the input files under their names at the time.
- In `lean/`, comments in `CS31a/KLSplit.lean`, `KLaneHom.lean`, `KLaneLeaf.lean`, `KLaneSem.lean`, `KLaneSound.lean`
  and `KLaneTree.lean` and in `build_k10.sh` and `build_k11.sh` were reworded after the proofs for h = 10, 11 and 12
  were built; nothing else in these files changed.
- `lean/tools_gen_kl.py` is the generator that wrote the h = 11 and h = 12 modules, without its test option `SPEC=1`
  and with one comment reworded; it reproduces those modules byte for byte.
- The module comments of `CS31aData/N13.lean` and `CS31aData/MainN13.lean`, the title in `gen/n13.json` from which
  `tools_gen_n13.py` writes them, the header of `tools_gen_n13.py` and the usage comment of `tools_build_native.sh` were
  reworded after the proof for h = 13 was built. A rebuild of these two modules from the shipped files, with the share
  modules of our run, gives the same declarations and the same axioms; only the comments stored in their compiled files
  differ.
- Six library modules (`CS31a/Cover.lean`, `CoverMain.lean`, `CoverStep.lean`, `KFastEq.lean`, `KLaneScalar.lean` and
  `KStepEq.lean`) store their absolute source path in a linter warning, so their `.olean` files differ between builds
  made at different absolute paths; the declarations are the same.

## Licence

Apache-2.0 for the programs (see `LICENSE`); the certificates and logs are released under CC BY 4.0 with the paper.
