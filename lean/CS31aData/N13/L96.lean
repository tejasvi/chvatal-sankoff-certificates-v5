import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 96 = cert_data/n13/h13c.low.part0096, entries 12482248704 .. 12612272127, chunks 2976 .. 3006
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l96 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0096" 390070272 12582912

end CS31aData.N13
