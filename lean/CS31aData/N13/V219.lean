import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 219 = cert_data/n13/h13c.vec.part0219, entries 21126709248 .. 21223178239, chunks 5037 .. 5059
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v219 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0219" 385875968 16777216

end CS31aData.N13
