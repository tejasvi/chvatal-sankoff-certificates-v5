import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 719 = cert_data/n13/h13c.low.part0719, entries 93486841856 .. 93616865279, chunks 22289 .. 22319
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l719 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0719" 390070272 12582912

end CS31aData.N13
