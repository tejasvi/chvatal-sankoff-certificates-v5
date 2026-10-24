import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 167 = cert_data/n13/h13c.low.part0167, entries 21713911808 .. 21843935231, chunks 5177 .. 5207
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l167 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0167" 390070272 12582912

end CS31aData.N13
