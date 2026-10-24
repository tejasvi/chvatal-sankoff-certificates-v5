import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 142 = cert_data/n13/h13c.low.part0142, entries 18463326208 .. 18593349631, chunks 4402 .. 4432
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l142 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0142" 390070272 12582912

end CS31aData.N13
