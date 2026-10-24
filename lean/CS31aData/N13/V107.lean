import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 107 = cert_data/n13/h13c.vec.part0107, entries 10322182144 .. 10418651135, chunks 2461 .. 2483
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v107 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0107" 385875968 16777216

end CS31aData.N13
