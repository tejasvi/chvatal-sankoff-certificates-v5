import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 616 = cert_data/n13/h13c.low.part0616, entries 80094429184 .. 80224452607, chunks 19096 .. 19126
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l616 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0616" 390070272 12582912

end CS31aData.N13
