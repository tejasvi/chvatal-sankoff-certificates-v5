import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1089 = cert_data/n13/h13c.vec.part1089, entries 105054732288 .. 105151201279, chunks 25047 .. 25069
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1089 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1089" 385875968 16777216

end CS31aData.N13
