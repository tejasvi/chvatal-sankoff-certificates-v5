import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 604 = cert_data/n13/h13c.low.part0604, entries 78534148096 .. 78664171519, chunks 18724 .. 18754
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l604 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0604" 390070272 12582912

end CS31aData.N13
