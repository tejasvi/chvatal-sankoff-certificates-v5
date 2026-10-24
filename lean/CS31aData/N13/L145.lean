import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 145 = cert_data/n13/h13c.low.part0145, entries 18853396480 .. 18983419903, chunks 4495 .. 4525
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l145 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0145" 390070272 12582912

end CS31aData.N13
