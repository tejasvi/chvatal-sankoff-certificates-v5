import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 367 = cert_data/n13/h13c.low.part0367, entries 47718596608 .. 47848620031, chunks 11377 .. 11407
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l367 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0367" 390070272 12582912

end CS31aData.N13
