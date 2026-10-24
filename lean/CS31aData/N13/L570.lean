import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 570 = cert_data/n13/h13c.low.part0570, entries 74113351680 .. 74243375103, chunks 17670 .. 17700
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l570 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0570" 390070272 12582912

end CS31aData.N13
