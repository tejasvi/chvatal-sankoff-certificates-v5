import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1674 = cert_data/n13/h13c.vec.part1674, entries 161489092608 .. 161585561599, chunks 38502 .. 38524
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1674 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1674" 385875968 16777216

end CS31aData.N13
