import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 504 = cert_data/n13/h13c.vec.part0504, entries 48620371968 .. 48716840959, chunks 11592 .. 11614
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v504 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0504" 385875968 16777216

end CS31aData.N13
