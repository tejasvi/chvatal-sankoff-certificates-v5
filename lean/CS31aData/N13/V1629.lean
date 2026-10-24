import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1629 = cert_data/n13/h13c.vec.part1629, entries 157147987968 .. 157244456959, chunks 37467 .. 37489
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1629 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1629" 385875968 16777216

end CS31aData.N13
