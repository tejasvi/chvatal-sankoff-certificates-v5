import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 332 = cert_data/n13/h13c.low.part0332, entries 43167776768 .. 43297800191, chunks 10292 .. 10322
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l332 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0332" 390070272 12582912

end CS31aData.N13
