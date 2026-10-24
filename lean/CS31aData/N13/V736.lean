import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 736 = cert_data/n13/h13c.vec.part0736, entries 71001178112 .. 71097647103, chunks 16928 .. 16950
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v736 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0736" 385875968 16777216

end CS31aData.N13
