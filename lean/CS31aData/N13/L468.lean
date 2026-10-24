import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 468 = cert_data/n13/h13c.low.part0468, entries 60850962432 .. 60980985855, chunks 14508 .. 14538
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l468 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0468" 390070272 12582912

end CS31aData.N13
