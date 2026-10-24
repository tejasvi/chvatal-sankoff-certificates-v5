import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 232 = cert_data/n13/h13c.low.part0232, entries 30165434368 .. 30295457791, chunks 7192 .. 7222
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l232 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0232" 390070272 12582912

end CS31aData.N13
