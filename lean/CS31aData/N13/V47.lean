import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 47 = cert_data/n13/h13c.vec.part0047, entries 4534042624 .. 4630511615, chunks 1081 .. 1103
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v47 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0047" 385875968 16777216

end CS31aData.N13
