import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 148 = cert_data/n13/h13c.low.part0148, entries 19243466752 .. 19373490175, chunks 4588 .. 4618
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l148 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0148" 390070272 12582912

end CS31aData.N13
