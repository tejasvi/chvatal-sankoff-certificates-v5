import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 163 = cert_data/n13/h13c.low.part0163, entries 21193818112 .. 21323841535, chunks 5053 .. 5083
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l163 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0163" 390070272 12582912

end CS31aData.N13
