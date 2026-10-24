import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 173 = cert_data/n13/h13c.vec.part0173, entries 16689135616 .. 16785604607, chunks 3979 .. 4001
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v173 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0173" 385875968 16777216

end CS31aData.N13
