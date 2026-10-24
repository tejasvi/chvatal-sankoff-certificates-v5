import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 751 = cert_data/n13/h13c.low.part0751, entries 97647591424 .. 97777614847, chunks 23281 .. 23311
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l751 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0751" 390070272 12582912

end CS31aData.N13
