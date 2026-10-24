import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 529 = cert_data/n13/h13c.low.part0529, entries 68782391296 .. 68912414719, chunks 16399 .. 16429
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l529 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0529" 390070272 12582912

end CS31aData.N13
