import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 828 = cert_data/n13/h13c.low.part0828, entries 107659395072 .. 107789418495, chunks 25668 .. 25698
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l828 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0828" 390070272 12582912

end CS31aData.N13
