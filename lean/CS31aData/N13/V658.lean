import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 658 = cert_data/n13/h13c.vec.part0658, entries 63476596736 .. 63573065727, chunks 15134 .. 15156
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v658 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0658" 385875968 16777216

end CS31aData.N13
