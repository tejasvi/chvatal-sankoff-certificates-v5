import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 912 = cert_data/n13/h13c.low.part0912, entries 118581362688 .. 118711386111, chunks 28272 .. 28302
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l912 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0912" 390070272 12582912

end CS31aData.N13
