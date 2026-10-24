import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 115 = cert_data/n13/h13c.vec.part0115, entries 11093934080 .. 11190403071, chunks 2645 .. 2667
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v115 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0115" 385875968 16777216

end CS31aData.N13
