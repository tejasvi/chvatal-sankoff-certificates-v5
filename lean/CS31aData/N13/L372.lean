import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 372 = cert_data/n13/h13c.low.part0372, entries 48368713728 .. 48498737151, chunks 11532 .. 11562
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l372 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0372" 390070272 12582912

end CS31aData.N13
