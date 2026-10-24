import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 199 = cert_data/n13/h13c.low.part0199, entries 25874661376 .. 26004684799, chunks 6169 .. 6199
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l199 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0199" 390070272 12582912

end CS31aData.N13
