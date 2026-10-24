import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 882 = cert_data/n13/h13c.low.part0882, entries 114680659968 .. 114810683391, chunks 27342 .. 27372
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l882 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0882" 390070272 12582912

end CS31aData.N13
