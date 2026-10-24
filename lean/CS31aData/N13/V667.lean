import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 667 = cert_data/n13/h13c.vec.part0667, entries 64344817664 .. 64441286655, chunks 15341 .. 15363
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v667 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0667" 385875968 16777216

end CS31aData.N13
