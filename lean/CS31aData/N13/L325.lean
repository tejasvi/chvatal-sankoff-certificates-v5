import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 325 = cert_data/n13/h13c.low.part0325, entries 42257612800 .. 42387636223, chunks 10075 .. 10105
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l325 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0325" 390070272 12582912

end CS31aData.N13
