import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1066 = cert_data/n13/h13c.vec.part1066, entries 102835945472 .. 102932414463, chunks 24518 .. 24540
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1066 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1066" 385875968 16777216

end CS31aData.N13
