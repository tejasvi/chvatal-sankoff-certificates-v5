import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 29 = cert_data/n13/h13c.low.part0029, entries 3770679296 .. 3900702719, chunks 899 .. 929
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l29 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0029" 390070272 12582912

end CS31aData.N13
