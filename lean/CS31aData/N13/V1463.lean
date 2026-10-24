import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1463 = cert_data/n13/h13c.vec.part1463, entries 141134135296 .. 141230604287, chunks 33649 .. 33671
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1463 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1463" 385875968 16777216

end CS31aData.N13
