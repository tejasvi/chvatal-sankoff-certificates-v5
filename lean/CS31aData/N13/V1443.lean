import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1443 = cert_data/n13/h13c.vec.part1443, entries 139204755456 .. 139301224447, chunks 33189 .. 33211
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1443 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1443" 385875968 16777216

end CS31aData.N13
