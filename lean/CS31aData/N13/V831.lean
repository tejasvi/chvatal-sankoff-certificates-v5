import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 831 = cert_data/n13/h13c.vec.part0831, entries 80165732352 .. 80262201343, chunks 19113 .. 19135
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v831 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0831" 385875968 16777216

end CS31aData.N13
