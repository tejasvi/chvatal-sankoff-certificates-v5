import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 694 = cert_data/n13/h13c.vec.part0694, entries 66949480448 .. 67045949439, chunks 15962 .. 15984
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v694 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0694" 385875968 16777216

end CS31aData.N13
