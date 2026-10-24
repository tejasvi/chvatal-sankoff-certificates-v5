import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 450 = cert_data/n13/h13c.low.part0450, entries 58510540800 .. 58640564223, chunks 13950 .. 13980
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l450 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0450" 390070272 12582912

end CS31aData.N13
