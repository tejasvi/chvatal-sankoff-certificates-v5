import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1019 = cert_data/n13/h13c.low.part1019, entries 132493869056 .. 132623892479, chunks 31589 .. 31619
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1019 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1019" 390070272 12582912

end CS31aData.N13
