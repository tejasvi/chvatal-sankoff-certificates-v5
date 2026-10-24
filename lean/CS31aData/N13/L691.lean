import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 691 = cert_data/n13/h13c.low.part0691, entries 89846185984 .. 89976209407, chunks 21421 .. 21451
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l691 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0691" 390070272 12582912

end CS31aData.N13
