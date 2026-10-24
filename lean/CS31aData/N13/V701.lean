import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 701 = cert_data/n13/h13c.vec.part0701, entries 67624763392 .. 67721232383, chunks 16123 .. 16145
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v701 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0701" 385875968 16777216

end CS31aData.N13
