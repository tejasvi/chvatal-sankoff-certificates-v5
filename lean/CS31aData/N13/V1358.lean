import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1358 = cert_data/n13/h13c.vec.part1358, entries 131004891136 .. 131101360127, chunks 31234 .. 31256
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1358 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1358" 385875968 16777216

end CS31aData.N13
