import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 713 = cert_data/n13/h13c.low.part0713, entries 92706701312 .. 92836724735, chunks 22103 .. 22133
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l713 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0713" 390070272 12582912

end CS31aData.N13
