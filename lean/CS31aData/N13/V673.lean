import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 673 = cert_data/n13/h13c.vec.part0673, entries 64923631616 .. 65020100607, chunks 15479 .. 15501
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v673 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0673" 385875968 16777216

end CS31aData.N13
