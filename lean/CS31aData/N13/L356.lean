import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 356 = cert_data/n13/h13c.low.part0356, entries 46288338944 .. 46418362367, chunks 11036 .. 11066
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l356 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0356" 390070272 12582912

end CS31aData.N13
