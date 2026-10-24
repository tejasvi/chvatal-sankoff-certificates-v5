import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 550 = cert_data/n13/h13c.vec.part0550, entries 53057945600 .. 53154414591, chunks 12650 .. 12672
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v550 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0550" 385875968 16777216

end CS31aData.N13
