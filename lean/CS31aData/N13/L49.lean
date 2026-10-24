import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 49 = cert_data/n13/h13c.low.part0049, entries 6371147776 .. 6501171199, chunks 1519 .. 1549
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l49 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0049" 390070272 12582912

end CS31aData.N13
