import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 490 = cert_data/n13/h13c.low.part0490, entries 63711477760 .. 63841501183, chunks 15190 .. 15220
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l490 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0490" 390070272 12582912

end CS31aData.N13
