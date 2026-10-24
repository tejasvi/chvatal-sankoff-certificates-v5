import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 993 = cert_data/n13/h13c.low.part0993, entries 129113260032 .. 129243283455, chunks 30783 .. 30813
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l993 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0993" 390070272 12582912

end CS31aData.N13
