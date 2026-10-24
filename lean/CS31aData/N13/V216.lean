import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 216 = cert_data/n13/h13c.vec.part0216, entries 20837302272 .. 20933771263, chunks 4968 .. 4990
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v216 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0216" 385875968 16777216

end CS31aData.N13
