import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 200 = cert_data/n13/h13c.vec.part0200, entries 19293798400 .. 19390267391, chunks 4600 .. 4622
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v200 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0200" 385875968 16777216

end CS31aData.N13
