import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 813 = cert_data/n13/h13c.vec.part0813, entries 78429290496 .. 78525759487, chunks 18699 .. 18721
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v813 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0813" 385875968 16777216

end CS31aData.N13
