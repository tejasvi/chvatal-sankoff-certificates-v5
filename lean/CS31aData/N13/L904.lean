import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 904 = cert_data/n13/h13c.low.part0904, entries 117541175296 .. 117671198719, chunks 28024 .. 28054
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l904 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0904" 390070272 12582912

end CS31aData.N13
