import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 350 = cert_data/n13/h13c.vec.part0350, entries 33764147200 .. 33860616191, chunks 8050 .. 8072
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v350 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0350" 385875968 16777216

end CS31aData.N13
