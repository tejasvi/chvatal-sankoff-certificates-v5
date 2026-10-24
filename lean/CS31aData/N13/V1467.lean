import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1467 = cert_data/n13/h13c.vec.part1467, entries 141520011264 .. 141616480255, chunks 33741 .. 33763
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1467 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1467" 385875968 16777216

end CS31aData.N13
