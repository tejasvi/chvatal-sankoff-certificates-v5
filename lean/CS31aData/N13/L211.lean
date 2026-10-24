import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 211 = cert_data/n13/h13c.low.part0211, entries 27434942464 .. 27564965887, chunks 6541 .. 6571
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l211 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0211" 390070272 12582912

end CS31aData.N13
