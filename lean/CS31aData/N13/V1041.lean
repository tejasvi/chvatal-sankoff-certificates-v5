import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1041 = cert_data/n13/h13c.vec.part1041, entries 100424220672 .. 100520689663, chunks 23943 .. 23965
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1041 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1041" 385875968 16777216

end CS31aData.N13
