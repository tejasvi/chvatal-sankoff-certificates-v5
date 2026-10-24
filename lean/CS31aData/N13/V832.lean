import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 832 = cert_data/n13/h13c.vec.part0832, entries 80262201344 .. 80358670335, chunks 19136 .. 19158
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v832 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0832" 385875968 16777216

end CS31aData.N13
