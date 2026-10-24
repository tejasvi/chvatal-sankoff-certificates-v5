import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 277 = cert_data/n13/h13c.low.part0277, entries 36016488448 .. 36146511871, chunks 8587 .. 8617
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l277 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0277" 390070272 12582912

end CS31aData.N13
