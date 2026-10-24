import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1665 = cert_data/n13/h13c.vec.part1665, entries 160620871680 .. 160717340671, chunks 38295 .. 38317
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1665 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1665" 385875968 16777216

end CS31aData.N13
