import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 788 = cert_data/n13/h13c.low.part0788, entries 102458458112 .. 102588481535, chunks 24428 .. 24458
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l788 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0788" 390070272 12582912

end CS31aData.N13
