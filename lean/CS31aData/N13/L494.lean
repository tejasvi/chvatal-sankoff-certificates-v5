import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 494 = cert_data/n13/h13c.low.part0494, entries 64231571456 .. 64361594879, chunks 15314 .. 15344
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l494 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0494" 390070272 12582912

end CS31aData.N13
