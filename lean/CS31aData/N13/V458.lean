import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 458 = cert_data/n13/h13c.vec.part0458, entries 44182798336 .. 44279267327, chunks 10534 .. 10556
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v458 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0458" 385875968 16777216

end CS31aData.N13
