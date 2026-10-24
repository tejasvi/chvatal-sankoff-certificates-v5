import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1636 = cert_data/n13/h13c.vec.part1636, entries 157823270912 .. 157919739903, chunks 37628 .. 37650
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1636 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1636" 385875968 16777216

end CS31aData.N13
