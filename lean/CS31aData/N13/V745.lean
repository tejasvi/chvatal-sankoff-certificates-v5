import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 745 = cert_data/n13/h13c.vec.part0745, entries 71869399040 .. 71965868031, chunks 17135 .. 17157
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v745 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0745" 385875968 16777216

end CS31aData.N13
