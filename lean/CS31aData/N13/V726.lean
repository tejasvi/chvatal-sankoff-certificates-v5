import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 726 = cert_data/n13/h13c.vec.part0726, entries 70036488192 .. 70132957183, chunks 16698 .. 16720
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v726 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0726" 385875968 16777216

end CS31aData.N13
