import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 198 = cert_data/n13/h13c.vec.part0198, entries 19100860416 .. 19197329407, chunks 4554 .. 4576
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v198 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0198" 385875968 16777216

end CS31aData.N13
