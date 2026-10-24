import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 763 = cert_data/n13/h13c.vec.part0763, entries 73605840896 .. 73702309887, chunks 17549 .. 17571
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v763 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0763" 385875968 16777216

end CS31aData.N13
