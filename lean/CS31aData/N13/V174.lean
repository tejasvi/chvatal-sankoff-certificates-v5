import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 174 = cert_data/n13/h13c.vec.part0174, entries 16785604608 .. 16882073599, chunks 4002 .. 4024
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v174 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0174" 385875968 16777216

end CS31aData.N13
