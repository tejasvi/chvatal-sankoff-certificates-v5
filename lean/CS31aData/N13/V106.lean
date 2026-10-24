import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 106 = cert_data/n13/h13c.vec.part0106, entries 10225713152 .. 10322182143, chunks 2438 .. 2460
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v106 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0106" 385875968 16777216

end CS31aData.N13
