import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 863 = cert_data/n13/h13c.low.part0863, entries 112210214912 .. 112340238335, chunks 26753 .. 26783
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l863 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0863" 390070272 12582912

end CS31aData.N13
