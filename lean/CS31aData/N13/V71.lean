import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 71 = cert_data/n13/h13c.vec.part0071, entries 6849298432 .. 6945767423, chunks 1633 .. 1655
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v71 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0071" 385875968 16777216

end CS31aData.N13
