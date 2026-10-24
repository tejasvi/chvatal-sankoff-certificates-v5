import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1404 = cert_data/n13/h13c.vec.part1404, entries 135442464768 .. 135538933759, chunks 32292 .. 32314
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1404 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1404" 385875968 16777216

end CS31aData.N13
