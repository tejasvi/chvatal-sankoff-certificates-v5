import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1167 = cert_data/n13/h13c.vec.part1167, entries 112579313664 .. 112675782655, chunks 26841 .. 26863
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1167 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1167" 385875968 16777216

end CS31aData.N13
