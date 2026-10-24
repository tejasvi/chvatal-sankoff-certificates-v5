import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 314 = cert_data/n13/h13c.low.part0314, entries 40827355136 .. 40957378559, chunks 9734 .. 9764
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l314 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0314" 390070272 12582912

end CS31aData.N13
