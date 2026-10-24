import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1151 = cert_data/n13/h13c.vec.part1151, entries 111035809792 .. 111132278783, chunks 26473 .. 26495
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1151 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1151" 385875968 16777216

end CS31aData.N13
