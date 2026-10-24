import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 410 = cert_data/n13/h13c.low.part0410, entries 53309603840 .. 53439627263, chunks 12710 .. 12740
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l410 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0410" 390070272 12582912

end CS31aData.N13
