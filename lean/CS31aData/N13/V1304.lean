import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1304 = cert_data/n13/h13c.vec.part1304, entries 125795565568 .. 125892034559, chunks 29992 .. 30014
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1304 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1304" 385875968 16777216

end CS31aData.N13
