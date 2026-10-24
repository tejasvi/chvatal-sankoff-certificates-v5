import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1272 = cert_data/n13/h13c.vec.part1272, entries 122708557824 .. 122805026815, chunks 29256 .. 29278
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1272 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1272" 385875968 16777216

end CS31aData.N13
