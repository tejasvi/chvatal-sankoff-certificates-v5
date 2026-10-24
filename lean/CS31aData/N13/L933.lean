import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 933 = cert_data/n13/h13c.low.part0933, entries 121311854592 .. 121441878015, chunks 28923 .. 28953
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l933 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0933" 390070272 12582912

end CS31aData.N13
