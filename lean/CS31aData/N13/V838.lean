import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 838 = cert_data/n13/h13c.vec.part0838, entries 80841015296 .. 80937484287, chunks 19274 .. 19296
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v838 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0838" 385875968 16777216

end CS31aData.N13
