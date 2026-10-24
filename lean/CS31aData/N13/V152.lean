import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 152 = cert_data/n13/h13c.vec.part0152, entries 14663286784 .. 14759755775, chunks 3496 .. 3518
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v152 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0152" 385875968 16777216

end CS31aData.N13
