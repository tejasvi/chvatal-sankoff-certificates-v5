import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 551 = cert_data/n13/h13c.vec.part0551, entries 53154414592 .. 53250883583, chunks 12673 .. 12695
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v551 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0551" 385875968 16777216

end CS31aData.N13
