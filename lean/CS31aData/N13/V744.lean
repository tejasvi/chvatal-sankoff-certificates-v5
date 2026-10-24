import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 744 = cert_data/n13/h13c.vec.part0744, entries 71772930048 .. 71869399039, chunks 17112 .. 17134
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v744 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0744" 385875968 16777216

end CS31aData.N13
