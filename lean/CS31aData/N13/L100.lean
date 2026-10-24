import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 100 = cert_data/n13/h13c.low.part0100, entries 13002342400 .. 13132365823, chunks 3100 .. 3130
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l100 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0100" 390070272 12582912

end CS31aData.N13
