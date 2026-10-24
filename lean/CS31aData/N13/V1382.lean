import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1382 = cert_data/n13/h13c.vec.part1382, entries 133320146944 .. 133416615935, chunks 31786 .. 31808
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1382 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1382" 385875968 16777216

end CS31aData.N13
