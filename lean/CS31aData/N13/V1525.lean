import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1525 = cert_data/n13/h13c.vec.part1525, entries 147115212800 .. 147211681791, chunks 35075 .. 35097
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1525 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1525" 385875968 16777216

end CS31aData.N13
