import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 606 = cert_data/n13/h13c.low.part0606, entries 78794194944 .. 78924218367, chunks 18786 .. 18816
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l606 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0606" 390070272 12582912

end CS31aData.N13
