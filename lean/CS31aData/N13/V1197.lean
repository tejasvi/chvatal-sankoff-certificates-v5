import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1197 = cert_data/n13/h13c.vec.part1197, entries 115473383424 .. 115569852415, chunks 27531 .. 27553
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1197 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1197" 385875968 16777216

end CS31aData.N13
