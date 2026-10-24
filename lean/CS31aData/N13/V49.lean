import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 49 = cert_data/n13/h13c.vec.part0049, entries 4726980608 .. 4823449599, chunks 1127 .. 1149
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v49 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0049" 385875968 16777216

end CS31aData.N13
