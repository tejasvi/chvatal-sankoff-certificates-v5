import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1486 = cert_data/n13/h13c.vec.part1486, entries 143352922112 .. 143449391103, chunks 34178 .. 34200
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1486 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1486" 385875968 16777216

end CS31aData.N13
