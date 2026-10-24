import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 762 = cert_data/n13/h13c.low.part0762, entries 99077849088 .. 99207872511, chunks 23622 .. 23652
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l762 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0762" 390070272 12582912

end CS31aData.N13
