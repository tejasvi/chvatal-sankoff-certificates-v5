import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 660 = cert_data/n13/h13c.vec.part0660, entries 63669534720 .. 63766003711, chunks 15180 .. 15202
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v660 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0660" 385875968 16777216

end CS31aData.N13
