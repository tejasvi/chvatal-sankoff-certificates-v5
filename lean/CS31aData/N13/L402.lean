import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 402 = cert_data/n13/h13c.low.part0402, entries 52269416448 .. 52399439871, chunks 12462 .. 12492
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l402 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0402" 390070272 12582912

end CS31aData.N13
