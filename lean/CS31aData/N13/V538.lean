import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 538 = cert_data/n13/h13c.vec.part0538, entries 51900317696 .. 51996786687, chunks 12374 .. 12396
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v538 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0538" 385875968 16777216

end CS31aData.N13
