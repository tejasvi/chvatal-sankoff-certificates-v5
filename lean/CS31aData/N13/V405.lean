import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 405 = cert_data/n13/h13c.vec.part0405, entries 39069941760 .. 39166410751, chunks 9315 .. 9337
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v405 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0405" 385875968 16777216

end CS31aData.N13
