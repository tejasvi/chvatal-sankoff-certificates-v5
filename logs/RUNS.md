# The logged checks

Each check ran `check H KEYS VEC WEIGHTS` with `OMP_NUM_THREADS` threads. `check.cpp` and `check_v1.cpp` in `src/`
differ from the sources that were compiled for these runs only in the second comment line (the compiled programs are
byte-identical); the SHA-256 values below are those of the compiled sources.

- `check.cpp` as compiled: SHA-256 `3704d6e5dbd1912057e05cbe0f8b3d9290568ab855078cb9badcb611111949dd`
- `check_v1.cpp` as compiled: SHA-256 `b2798a649409a7bb82762d05e55fb7db4ecbccc7c75325e8db48b709e856cb95`

| log | checker | h, z | keys (SHA-256) | v (SHA-256) | weights (SHA-256) | threads | Λ |
|---|---|---|---|---|---|---|---|
| `check_h8_0.3209.out` | `check.cpp` | 8, 0.3209 | `e3def50f04811580fa19b034d4b94771f61e71831ab5a4b3c3af0a33f495b0a3` | `121ccf4f8eff056abdc7964901b1a465dbc9efba8c8bfda9d0e3e9462f7653af` | `ecb5fa85…` | 24 | 6305692192723871581 |
| `check_h9_0.3298.out` | `check.cpp` | 9, 0.3298 | `ce295f3eb17e476ddf6ae3c0aff18f9fcb5ff587977baa4f8d416890c1a43fa4` | `debdd3f25f3860c23ddda201e4caaaab1b31eea2e7eb8b30d6afac6b00325c54` | `aa7a448a…` | 24 | 6727681800027252070 |
| `check_h10_0.3376.out` | `check.cpp` | 10, 0.3376 | `3addff1b337b284fe698772f1fc26a4ca191057b14a2b9650dafbf1bd8b4e53d` | `4eb81b8716615ba6bf32193048da9eecdddf58cc98a5fdc9d741aec79e8cba10` | `68a85e6b…` | 24 | 7111821154096593734 |
| `check_h11_0.3445.out` | `check.cpp` | 11, 0.3445 | `58c8ae21c93a2fd7c676a98eef53579092d90289275ff8e256b0cb947b35953c` | `a62dfee569f8b446ef0342c4d7bf072f0362f48ac175f0b05b5dd627654fd1ee` | `54a2d528…` | 64 | 7462926034979082163 |
| `check_h12_0.3505.out` | `check.cpp` | 12, 0.3505 | `bef385e5bdc772fdc198ad3fddb268e392105c06c30288025c50bbad42e258c5` | `915ac393b4952851e72938e4aea097c566039a43546b75a3a0fa8c760221c865` | `8e53ffd9…` | 288 | 7776813894375449830 |
| `earlier_runs/check_h11_0.3445_v1.out` | `check_v1.cpp` | 11, 0.3445 | `58c8ae21c93a2fd7c676a98eef53579092d90289275ff8e256b0cb947b35953c` | `a62dfee569f8b446ef0342c4d7bf072f0362f48ac175f0b05b5dd627654fd1ee` | `54a2d528…` | 192 | 7462926034979082163 |
| `earlier_runs/check_h12_0.3505_first.out` | `check.cpp` | 12, 0.3505 | `bef385e5bdc772fdc198ad3fddb268e392105c06c30288025c50bbad42e258c5` | `a279cb60a96568622b11f52a1ea1be592064e83bc2dd762e819d1ab9ba59a8a3` | `8e53ffd9…` | 288 | 7776814459376720853 |

The weight files are `weights/w_h<H>_<z>.txt`; their full SHA-256 values are in `SHA256SUMS`.
The `h = 12` vector of record is the output of `mhstream_det` (see the README). The last two rows are earlier checks:
the first check of the `h = 11` certificate, with `check_v1.cpp`, and the check of a first `h = 12` vector, from a run of
`mhstream` that cannot be regenerated bit for bit, which is not archived.
`earlier_runs/` also holds the first checks of the `h = 9` and `h = 10` certificates (the same files as above), which gave
the same `Λ`; the `h = 10` checks used `check_v1.cpp`, and `earlier_runs/check_h9_0.3298_v1.out` is a check of the
`h = 9` certificate with `check_v1.cpp` (16 threads), with the same `Λ`.
`validation/validate_check_h2_9.out` and `validate_check_h10.out` come from `validate_check.cpp` with `check.cpp`;
`earlier_runs/validate_check_h10.out` is the same comparison with `check_v1.cpp`.
