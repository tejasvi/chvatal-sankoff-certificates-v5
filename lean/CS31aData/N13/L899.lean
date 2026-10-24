import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 899 = cert_data/n13/h13c.low.part0899, entries 116891058176 .. 117021081599, chunks 27869 .. 27899
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l899 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0899" 390070272 12582912

end CS31aData.N13
