import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 452 = cert_data/n13/h13c.vec.part0452, entries 43603984384 .. 43700453375, chunks 10396 .. 10418
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v452 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0452" 385875968 16777216

end CS31aData.N13
