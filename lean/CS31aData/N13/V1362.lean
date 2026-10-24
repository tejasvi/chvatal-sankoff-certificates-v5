import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1362 = cert_data/n13/h13c.vec.part1362, entries 131390767104 .. 131487236095, chunks 31326 .. 31348
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1362 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1362" 385875968 16777216

end CS31aData.N13
