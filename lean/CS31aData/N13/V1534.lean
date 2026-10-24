import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1534 = cert_data/n13/h13c.vec.part1534, entries 147983433728 .. 148079902719, chunks 35282 .. 35304
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1534 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1534" 385875968 16777216

end CS31aData.N13
