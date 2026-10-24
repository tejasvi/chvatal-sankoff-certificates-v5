import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 571 = cert_data/n13/h13c.low.part0571, entries 74243375104 .. 74373398527, chunks 17701 .. 17731
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l571 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0571" 390070272 12582912

end CS31aData.N13
