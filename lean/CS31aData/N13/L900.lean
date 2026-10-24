import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 900 = cert_data/n13/h13c.low.part0900, entries 117021081600 .. 117151105023, chunks 27900 .. 27930
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l900 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0900" 390070272 12582912

end CS31aData.N13
