import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 453 = cert_data/n13/h13c.low.part0453, entries 58900611072 .. 59030634495, chunks 14043 .. 14073
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l453 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0453" 390070272 12582912

end CS31aData.N13
