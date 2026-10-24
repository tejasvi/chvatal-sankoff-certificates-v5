import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 512 = cert_data/n13/h13c.low.part0512, entries 66571993088 .. 66702016511, chunks 15872 .. 15902
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l512 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0512" 390070272 12582912

end CS31aData.N13
