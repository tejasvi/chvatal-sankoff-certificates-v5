import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 744 = cert_data/n13/h13c.low.part0744, entries 96737427456 .. 96867450879, chunks 23064 .. 23094
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l744 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0744" 390070272 12582912

end CS31aData.N13
