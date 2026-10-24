import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1087 = cert_data/n13/h13c.low.part1087, entries 141335461888 .. 141465485311, chunks 33697 .. 33727
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1087 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1087" 390070272 12582912

end CS31aData.N13
