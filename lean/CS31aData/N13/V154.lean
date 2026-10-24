import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 154 = cert_data/n13/h13c.vec.part0154, entries 14856224768 .. 14952693759, chunks 3542 .. 3564
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v154 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0154" 385875968 16777216

end CS31aData.N13
