import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 635 = cert_data/n13/h13c.vec.part0635, entries 61257809920 .. 61354278911, chunks 14605 .. 14627
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v635 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0635" 385875968 16777216

end CS31aData.N13
