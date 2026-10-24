import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 520 = cert_data/n13/h13c.low.part0520, entries 67612180480 .. 67742203903, chunks 16120 .. 16150
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l520 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0520" 390070272 12582912

end CS31aData.N13
