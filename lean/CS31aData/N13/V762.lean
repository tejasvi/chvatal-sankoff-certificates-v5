import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 762 = cert_data/n13/h13c.vec.part0762, entries 73509371904 .. 73605840895, chunks 17526 .. 17548
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v762 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0762" 385875968 16777216

end CS31aData.N13
