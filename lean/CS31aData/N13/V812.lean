import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 812 = cert_data/n13/h13c.vec.part0812, entries 78332821504 .. 78429290495, chunks 18676 .. 18698
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v812 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0812" 385875968 16777216

end CS31aData.N13
