import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 270 = cert_data/n13/h13c.vec.part0270, entries 26046627840 .. 26143096831, chunks 6210 .. 6232
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v270 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0270" 385875968 16777216

end CS31aData.N13
