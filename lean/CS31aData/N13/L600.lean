import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 600 = cert_data/n13/h13c.low.part0600, entries 78014054400 .. 78144077823, chunks 18600 .. 18630
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l600 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0600" 390070272 12582912

end CS31aData.N13
