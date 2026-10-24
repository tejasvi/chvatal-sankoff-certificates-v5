import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1008 = cert_data/n13/h13c.low.part1008, entries 131063611392 .. 131193634815, chunks 31248 .. 31278
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1008 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1008" 390070272 12582912

end CS31aData.N13
