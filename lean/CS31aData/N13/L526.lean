import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 526 = cert_data/n13/h13c.low.part0526, entries 68392321024 .. 68522344447, chunks 16306 .. 16336
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l526 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0526" 390070272 12582912

end CS31aData.N13
