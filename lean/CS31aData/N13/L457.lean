import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 457 = cert_data/n13/h13c.low.part0457, entries 59420704768 .. 59550728191, chunks 14167 .. 14197
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l457 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0457" 390070272 12582912

end CS31aData.N13
