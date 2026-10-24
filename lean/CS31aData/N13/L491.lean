import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 491 = cert_data/n13/h13c.low.part0491, entries 63841501184 .. 63971524607, chunks 15221 .. 15251
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l491 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0491" 390070272 12582912

end CS31aData.N13
