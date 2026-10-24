import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 906 = cert_data/n13/h13c.vec.part0906, entries 87400906752 .. 87497375743, chunks 20838 .. 20860
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v906 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0906" 385875968 16777216

end CS31aData.N13
