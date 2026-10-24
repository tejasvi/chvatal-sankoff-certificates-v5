import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 439 = cert_data/n13/h13c.low.part0439, entries 57080283136 .. 57210306559, chunks 13609 .. 13639
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l439 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0439" 390070272 12582912

end CS31aData.N13
