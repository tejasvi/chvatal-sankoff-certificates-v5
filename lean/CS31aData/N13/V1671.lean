import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1671 = cert_data/n13/h13c.vec.part1671, entries 161199685632 .. 161296154623, chunks 38433 .. 38455
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1671 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1671" 385875968 16777216

end CS31aData.N13
