import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 416 = cert_data/n13/h13c.vec.part0416, entries 40131100672 .. 40227569663, chunks 9568 .. 9590
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v416 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0416" 385875968 16777216

end CS31aData.N13
