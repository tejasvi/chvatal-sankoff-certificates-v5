import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 465 = cert_data/n13/h13c.vec.part0465, entries 44858081280 .. 44954550271, chunks 10695 .. 10717
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v465 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0465" 385875968 16777216

end CS31aData.N13
