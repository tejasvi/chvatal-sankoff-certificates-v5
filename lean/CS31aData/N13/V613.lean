import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 613 = cert_data/n13/h13c.vec.part0613, entries 59135492096 .. 59231961087, chunks 14099 .. 14121
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v613 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0613" 385875968 16777216

end CS31aData.N13
