import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 926 = cert_data/n13/h13c.low.part0926, entries 120401690624 .. 120531714047, chunks 28706 .. 28736
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l926 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0926" 390070272 12582912

end CS31aData.N13
