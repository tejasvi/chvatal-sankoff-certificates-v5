import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1472 = cert_data/n13/h13c.vec.part1472, entries 142002356224 .. 142098825215, chunks 33856 .. 33878
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1472 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1472" 385875968 16777216

end CS31aData.N13
