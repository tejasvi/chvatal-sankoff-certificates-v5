import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 293 = cert_data/n13/h13c.vec.part0293, entries 28265414656 .. 28361883647, chunks 6739 .. 6761
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v293 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0293" 385875968 16777216

end CS31aData.N13
